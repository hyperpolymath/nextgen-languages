-- SPDX-License-Identifier: AGPL-3.0-or-later
-- SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
--
-- AOLDI - Aspect Oriented Language Development Interface
-- Core Framework Specification
--
-- This is the central hub for coordinating language development across
-- the NextGen Languages ecosystem. It provides:
--   1. Plugin architecture for language implementations
--   2. Aggregate library loading and parsing
--   3. Echidna integration for formal verification
--   4. SLM (Small Language Model) direct access interface

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Hash;

package AOLDI is

   pragma Pure;

   --=========================================================================
   -- Version Information
   --=========================================================================

   Version_Major : constant := 0;
   Version_Minor : constant := 1;
   Version_Patch : constant := 0;

   function Version return String is
      (Version_Major'Image & "." & Version_Minor'Image & "." & Version_Patch'Image);

   --=========================================================================
   -- Core Types
   --=========================================================================

   type Language_ID is new Unbounded_String;
   type Plugin_ID is new Unbounded_String;
   type Operation_ID is new Unbounded_String;

   -- Completion status for tracking development progress
   type Completion_Percentage is range 0 .. 100;

   -- Plugin categories
   type Plugin_Category is
     (Language_Plugin,      -- A programming language implementation
      Verification_Plugin,  -- Formal verification (e.g., Echidna)
      Library_Plugin,       -- Standard/aggregate library
      Tool_Plugin,          -- Development tools (lexer gen, etc.)
      SLM_Plugin);          -- Small Language Model integration

   -- Language family classification
   type Language_Family is
     (My_Language_Family,     -- Me, Solo, Duet, Ensemble
      Foundational_Languages, -- betlang, julia-the-viper
      Specialized_Languages,  -- Phronesis, Eclexia, Oblibeny, etc.
      Advanced_Type_Systems); -- AffineScript, Ephapax

   --=========================================================================
   -- Aggregate Library Operations (from aLib specification)
   --=========================================================================

   type Aggregate_Category is
     (Arithmetic,   -- add, subtract, multiply, divide, modulo
      Comparison,   -- less_than, greater_than, equal, not_equal, etc.
      Logical,      -- and, or, not
      String_Ops,   -- concat, length, substring
      Collection,   -- map, filter, fold, contains
      Conditional); -- if_then_else

   type Aggregate_Operation is record
      Name        : Operation_ID;
      Category    : Aggregate_Category;
      Signature   : Unbounded_String;  -- Abstract signature
      Semantics   : Unbounded_String;  -- Behavioral description
      Test_Cases  : Unbounded_String;  -- YAML test cases
   end record;

   --=========================================================================
   -- Plugin Metadata
   --=========================================================================

   type Plugin_Info is record
      ID          : Plugin_ID;
      Name        : Unbounded_String;
      Category    : Plugin_Category;
      Version     : Unbounded_String;
      Description : Unbounded_String;
      Repository  : Unbounded_String;  -- GitHub URL
      Completion  : Completion_Percentage;
      Enabled     : Boolean := False;
   end record;

   --=========================================================================
   -- Language-Specific Metadata
   --=========================================================================

   type Language_Info is record
      ID              : Language_ID;
      Name            : Unbounded_String;
      Family          : Language_Family;
      Implementation  : Unbounded_String;  -- Rust, Elixir, OCaml, etc.
      Target          : Unbounded_String;  -- WASM, Native, BEAM, etc.
      Completion      : Completion_Percentage;
      Has_Lexer       : Boolean := False;
      Has_Parser      : Boolean := False;
      Has_Compiler    : Boolean := False;
      Has_Interpreter : Boolean := False;
      Has_REPL        : Boolean := False;
      Has_LSP         : Boolean := False;
      Supports_Echidna : Boolean := False;
   end record;

end AOLDI;
