#!/usr/bin/env julia
# SPDX-License-Identifier: PMPL-1.0-or-later
#
# Repo Reconciliation Tool
# Compares GitLab and GitHub repositories to identify sync gaps.
#
# Usage:
#   export GITLAB_TOKEN="your-token"
#   export GITHUB_TOKEN="your-token"
#   julia repo-reconcile.jl
#
# Quick check mode (no auth needed):
#   julia repo-reconcile.jl check repo1 repo2 repo3
#
# Outputs a reconciliation report showing:
#   - Repos only on GitLab (need to mirror to GitHub)
#   - Repos only on GitHub (new creations or need to mirror to GitLab)
#   - Repos on both (check if synced or diverged)

using JSON3
using Dates
using HTTP  # HTTP.jl for REST calls

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

const GITLAB_USER   = "hyperpolymath"
const GITLAB_GROUPS = ["maa-framework"]  # Add more groups as needed
const GITHUB_USER   = "hyperpolymath"

# ---------------------------------------------------------------------------
# Data types
# ---------------------------------------------------------------------------

"""A repository entry from either GitLab or GitHub."""
struct Repo
    name::String
    platform::String
    url::String
    last_activity::Union{String, Nothing}
    commit_count::Union{Int, Nothing}
    description::Union{String, Nothing}
end

# Convenience constructor (mirrors the Python dataclass defaults).
Repo(name, platform, url, last_activity;
     commit_count=nothing, description=nothing) =
    Repo(name, platform, url, last_activity, commit_count, description)

# ---------------------------------------------------------------------------
# GitLab helpers
# ---------------------------------------------------------------------------

"""Fetch all repos from GitLab user and groups, paginated."""
function get_gitlab_repos(token::String)::Vector{Repo}
    repos = Repo[]
    headers = ["PRIVATE-TOKEN" => token]

    # --- User repos ---
    page = 1
    while true
        url = "https://gitlab.com/api/v4/users/$(GITLAB_USER)/projects?per_page=100&page=$(page)"
        resp = HTTP.get(url, headers; status_exception=false)
        if resp.status != 200
            println("GitLab API error: $(resp.status)")
            break
        end
        data = JSON3.read(resp.body)
        isempty(data) && break
        for r in data
            push!(repos, Repo(
                r[:path],
                "gitlab",
                r[:web_url],
                get(r, :last_activity_at, nothing);
                description = get(r, :description, nothing)
            ))
        end
        page += 1
    end

    # --- Group repos ---
    for group in GITLAB_GROUPS
        page = 1
        while true
            url = "https://gitlab.com/api/v4/groups/$(group)/projects?per_page=100&page=$(page)&include_subgroups=true"
            resp = HTTP.get(url, headers; status_exception=false)
            resp.status != 200 && break
            data = JSON3.read(resp.body)
            isempty(data) && break
            for r in data
                push!(repos, Repo(
                    r[:path],
                    "gitlab",
                    r[:web_url],
                    get(r, :last_activity_at, nothing);
                    description = get(r, :description, nothing)
                ))
            end
            page += 1
        end
    end

    return repos
end

# ---------------------------------------------------------------------------
# GitHub helpers
# ---------------------------------------------------------------------------

"""Fetch all repos from GitHub user, paginated."""
function get_github_repos(token::String)::Vector{Repo}
    repos = Repo[]
    headers = ["Authorization" => "token $(token)"]

    page = 1
    while true
        url = "https://api.github.com/users/$(GITHUB_USER)/repos?per_page=100&page=$(page)"
        resp = HTTP.get(url, headers; status_exception=false)
        if resp.status != 200
            println("GitHub API error: $(resp.status)")
            break
        end
        data = JSON3.read(resp.body)
        isempty(data) && break
        for r in data
            push!(repos, Repo(
                r[:name],
                "github",
                r[:html_url],
                get(r, :pushed_at, nothing);
                description = get(r, :description, nothing)
            ))
        end
        page += 1
    end

    return repos
end

# ---------------------------------------------------------------------------
# Reconciliation logic
# ---------------------------------------------------------------------------

"""Compare repos and categorise sync status. Returns a Dict of categories."""
function reconcile(gitlab_repos::Vector{Repo},
                   github_repos::Vector{Repo})::Dict{String, Vector}
    gitlab_names = Dict(r.name => r for r in gitlab_repos)
    github_names = Dict(r.name => r for r in github_repos)

    all_names = union(keys(gitlab_names), keys(github_names))

    result = Dict{String, Vector}(
        "gitlab_only"   => [],
        "github_only"   => [],
        "both_synced"   => [],
        "both_diverged" => [],
        "unknown"       => []
    )

    for name in sort(collect(all_names))
        gl = get(gitlab_names, name, nothing)
        gh = get(github_names, name, nothing)

        if !isnothing(gl) && isnothing(gh)
            push!(result["gitlab_only"], Dict(
                "name"          => name,
                "gitlab_url"    => gl.url,
                "last_activity" => gl.last_activity,
                "action"        => "Mirror to GitHub"
            ))
        elseif !isnothing(gh) && isnothing(gl)
            push!(result["github_only"], Dict(
                "name"          => name,
                "github_url"    => gh.url,
                "last_activity" => gh.last_activity,
                "action"        => "New on GitHub (mirror to GitLab?)"
            ))
        else
            # Both exist — check if diverged
            gl_time = something(gl.last_activity, "")
            gh_time = something(gh.last_activity, "")

            try
                # Parse ISO-8601 timestamps (replace trailing Z with +00:00)
                gl_dt = DateTime(replace(gl_time, "Z" => "+00:00")[1:min(end, 19)],
                                 dateformat"yyyy-mm-ddTHH:MM:SS")
                gh_dt = DateTime(replace(gh_time, "Z" => "+00:00")[1:min(end, 19)],
                                 dateformat"yyyy-mm-ddTHH:MM:SS")
                diff_days = abs(Dates.value(Day(gl_dt - gh_dt)))

                if diff_days > 1
                    ahead = gl_dt > gh_dt ? "GitLab" : "GitHub"
                    push!(result["both_diverged"], Dict(
                        "name"            => name,
                        "gitlab_url"      => gl.url,
                        "github_url"      => gh.url,
                        "gitlab_activity" => gl_time,
                        "github_activity" => gh_time,
                        "ahead"           => ahead,
                        "days_apart"      => diff_days,
                        "action"          => "Check sync - $(ahead) is $(diff_days) days ahead"
                    ))
                else
                    push!(result["both_synced"], Dict(
                        "name"   => name,
                        "status" => "Likely synced"
                    ))
                end
            catch
                push!(result["unknown"], Dict(
                    "name"       => name,
                    "gitlab_url" => isnothing(gl) ? nothing : gl.url,
                    "github_url" => isnothing(gh) ? nothing : gh.url,
                    "action"     => "Could not compare dates"
                ))
            end
        end
    end

    return result
end

# ---------------------------------------------------------------------------
# Report printer
# ---------------------------------------------------------------------------

"""Print human-readable reconciliation report."""
function print_report(result::Dict{String, Vector})
    println()
    println("=" ^ 70)
    println("REPOSITORY RECONCILIATION REPORT")
    println("=" ^ 70)

    n_gl = length(result["gitlab_only"])
    println("\n## GITLAB ONLY ($(n_gl) repos)")
    println("These repos exist on GitLab but NOT on GitHub:")
    for r in result["gitlab_only"][1:min(end, 20)]
        println("  - $(r["name"]): $(r["gitlab_url"])")
    end
    n_gl > 20 && println("  ... and $(n_gl - 20) more")

    n_gh = length(result["github_only"])
    println("\n## GITHUB ONLY ($(n_gh) repos)")
    println("These repos exist on GitHub but NOT on GitLab:")
    for r in result["github_only"][1:min(end, 20)]
        println("  - $(r["name"]): $(r["github_url"])")
    end
    n_gh > 20 && println("  ... and $(n_gh - 20) more")

    n_div = length(result["both_diverged"])
    println("\n## POTENTIALLY DIVERGED ($(n_div) repos)")
    println("These repos exist on both but may be out of sync:")
    for r in result["both_diverged"]
        println("  - $(r["name"]): $(r["ahead"]) ahead by $(r["days_apart"]) days")
    end

    n_sync = length(result["both_synced"])
    println("\n## LIKELY SYNCED ($(n_sync) repos)")

    println()
    println("=" ^ 70)
    println("SUMMARY")
    println("=" ^ 70)
    # Right-align counts to 4 chars, matching the Python format
    println("  GitLab only:      $(lpad(string(n_gl), 4)) (need to mirror to GitHub)")
    println("  GitHub only:      $(lpad(string(n_gh), 4)) (new on GitHub)")
    println("  Diverged:         $(lpad(string(n_div), 4)) (need sync check)")
    println("  Synced:           $(lpad(string(n_sync), 4)) (OK)")
    println("  Unknown:          $(lpad(string(length(result["unknown"])), 4))")
end

# ---------------------------------------------------------------------------
# Quick check mode (no auth required)
# ---------------------------------------------------------------------------

"""Check if repos exist on GitHub without authentication (HEAD requests)."""
function quick_check_github(repos::Vector{String})::Dict{String, Vector{String}}
    results = Dict("exists" => String[], "missing" => String[])
    for repo in repos
        url = "https://github.com/hyperpolymath/$(repo)"
        try
            resp = HTTP.head(url; status_exception=false, connect_timeout=5,
                             readtimeout=5)
            if resp.status < 400
                push!(results["exists"], repo)
            else
                push!(results["missing"], repo)
            end
        catch
            push!(results["missing"], repo)
        end
    end
    return results
end

# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

function main()
    # Quick-check mode: julia repo-reconcile.jl check repo1 repo2 ...
    if length(ARGS) >= 2 && ARGS[1] == "check"
        repos = ARGS[2:end]
        println("Checking $(length(repos)) repos against GitHub...")
        results = quick_check_github(repos)
        println("\n✓ EXISTS on GitHub ($(length(results["exists"]))):")
        for r in results["exists"]
            println("  $(r)")
        end
        println("\n✗ MISSING on GitHub ($(length(results["missing"]))):")
        for r in results["missing"]
            println("  $(r)")
        end
        return
    end

    # Full reconciliation mode
    gitlab_token = get(ENV, "GITLAB_TOKEN", "")
    github_token = get(ENV, "GITHUB_TOKEN", "")

    if isempty(gitlab_token) || isempty(github_token)
        println("Please set GITLAB_TOKEN and GITHUB_TOKEN environment variables")
        println("\nTo get tokens:")
        println("  GitLab: Settings > Access Tokens > Create with 'read_api' scope")
        println("  GitHub: Settings > Developer settings > Personal access tokens")
        return
    end

    println("Fetching GitLab repos...")
    gitlab_repos = get_gitlab_repos(gitlab_token)
    println("  Found $(length(gitlab_repos)) GitLab repos")

    println("Fetching GitHub repos...")
    github_repos = get_github_repos(github_token)
    println("  Found $(length(github_repos)) GitHub repos")

    println("Reconciling...")
    result = reconcile(gitlab_repos, github_repos)

    print_report(result)

    # Save full report as JSON
    open("reconciliation-report.json", "w") do f
        JSON3.pretty(f, result)
    end
    println("\nFull report saved to reconciliation-report.json")
end

main()
