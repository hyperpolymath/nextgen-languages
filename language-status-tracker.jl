#!/usr/bin/env julia
# SPDX-License-Identifier: PMPL-1.0-or-later
# Language Repository Status Tracker
# Run this daily to see exactly what state everything is in

using Dates

const REPOS_DIR = joinpath(homedir(), "Documents/hyperpolymath-repos")

# All known language repos
const LANGUAGES = [
    # Core 8 nextgen languages
    "affinescript", "anvomidav", "betlang", "eclexia", "ephapax",
    "julia-the-viper", "my-lang", "oblibeny", "phronesis", "wokelang",

    # Database/specialized
    "fqldt", "a2ml", "k9-svc",

    # Supporting
    "error-lang", "universal-language-server-plugin",

    # Playgrounds
    "betlang-playground", "ephapax-playground", "error-lang-playground", "mylang-playground",

    # Ephapax ecosystem
    "ephapax-proven", "ephapax-proven-ffi", "ephapax-proven-sys", "ephapax-ssg",

    # WokeLang ecosystem
    "wokelang-ssg",

    # Umbrella
    "nextgen-languages",
]

struct RepoStatus
    name::String
    exists::Bool
    is_git::Bool
    src_files::Int
    last_commit::String
    commit_count::Int
    has_cargo::Bool
    has_dune::Bool
    has_package_json::Bool
end

function count_source_files(path)
    count = 0
    for ext in [".rs", ".ml", ".js", ".ts", ".res", ".idr", ".zig"]
        try
            result = read(`find $path -name "*$ext" -type f`, String)
            count += length(split(strip(result), '\n'))
        catch
            continue
        end
    end
    return count
end

function get_repo_status(name)
    path = joinpath(REPOS_DIR, name)

    if !isdir(path)
        return RepoStatus(name, false, false, 0, "", 0, false, false, false)
    end

    is_git = isdir(joinpath(path, ".git"))

    last_commit = ""
    commit_count = 0
    if is_git
        try
            cd(path) do
                last_commit = strip(read(`git log -1 --format=%ar`, String))
                commit_count = parse(Int, strip(read(`git rev-list --count HEAD`, String)))
            end
        catch
            last_commit = "ERROR"
            commit_count = 0
        end
    end

    src_files = count_source_files(path)
    has_cargo = isfile(joinpath(path, "Cargo.toml"))
    has_dune = isfile(joinpath(path, "dune-project"))
    has_package_json = isfile(joinpath(path, "package.json"))

    return RepoStatus(name, true, is_git, src_files, last_commit, commit_count,
                     has_cargo, has_dune, has_package_json)
end

function language_type(status)
    if status.has_cargo
        return "Rust"
    elseif status.has_dune
        return "OCaml"
    elseif status.has_package_json
        return "JS/ReScript"
    else
        return "Unknown"
    end
end

function status_emoji(status)
    if !status.exists
        return "❌"
    elseif status.src_files == 0
        return "🔴"
    elseif status.src_files < 10
        return "🟡"
    elseif status.src_files < 40
        return "🟠"
    else
        return "🟢"
    end
end

println("=" ^ 80)
println("LANGUAGE REPOSITORY STATUS REPORT")
println("Generated: ", Dates.format(now(), "yyyy-mm-dd HH:MM:SS"))
println("=" ^ 80)
println()

# Collect all statuses
statuses = [get_repo_status(lang) for lang in LANGUAGES]

# Summary
total = length(statuses)
existing = count(s -> s.exists, statuses)
with_code = count(s -> s.src_files > 0, statuses)
production_ready = count(s -> s.src_files >= 40, statuses)

println("SUMMARY")
println("-------")
println("  Total repos tracked: $total")
println("  Exist on disk: $existing")
println("  Have source code: $with_code")
println("  Production-ready (40+ files): $production_ready")
println()

# Detailed table
println("DETAILED STATUS")
println("---------------")
println()
println("| Repo | Status | Type | Files | Commits | Last Updated |")
println("|------|--------|------|-------|---------|--------------|")

for status in sort(statuses, by=s->(-s.src_files, s.name))
    emoji = status_emoji(status)
    type_str = status.exists ? language_type(status) : "N/A"
    files = status.exists ? string(status.src_files) : "-"
    commits = status.is_git ? string(status.commit_count) : "-"
    last = status.is_git ? status.last_commit : "-"

    println("| $(status.name) | $emoji | $type_str | $files | $commits | $last |")
end

println()
println("=" ^ 80)
println()

# Production ready list
println("🟢 PRODUCTION READY (40+ source files):")
println("-" ^ 40)
for status in filter(s -> s.src_files >= 40, statuses)
    println("  • $(status.name) ($(status.src_files) files, $(language_type(status)))")
end
println()

# In progress list
println("🟡 IN PROGRESS (1-39 source files):")
println("-" ^ 40)
for status in filter(s -> s.src_files > 0 && s.src_files < 40, statuses)
    println("  • $(status.name) ($(status.src_files) files, $(language_type(status)))")
end
println()

# Not started
println("🔴 NOT STARTED (0 source files):")
println("-" ^ 40)
for status in filter(s -> s.exists && s.src_files == 0, statuses)
    println("  • $(status.name) ($(language_type(status)))")
end
println()

# Missing
println("❌ MISSING (not found on disk):")
println("-" ^ 40)
for status in filter(s -> !s.exists, statuses)
    println("  • $(status.name)")
end
println()

println("=" ^ 80)
println("Next steps:")
println("  1. Review production-ready repos for release")
println("  2. Focus development on in-progress repos")
println("  3. Decide: continue or archive not-started repos")
println("  4. Investigate missing repos")
println("=" ^ 80)
