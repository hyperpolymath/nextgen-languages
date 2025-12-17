-- SPDX-License-Identifier: AGPL-3.0-or-later
-- SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
--
-- AOLDI.Plugins - Generic Plugin Interface
--
-- Defines the abstract interface that all plugins must implement.
-- This enables hot-loading of language implementations, verification
-- tools, and other components.

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
with AOLDI;

package AOLDI.Plugins is

   --=========================================================================
   -- Abstract Plugin Interface
   --=========================================================================

   type Plugin_Interface is interface;
   type Plugin_Access is access all Plugin_Interface'Class;

   -- Required operations for all plugins
   function Get_Info (Self : Plugin_Interface) return Plugin_Info is abstract;
   function Initialize (Self : in out Plugin_Interface) return Boolean is abstract;
   procedure Shutdown (Self : in out Plugin_Interface) is abstract;
   function Is_Ready (Self : Plugin_Interface) return Boolean is abstract;

   -- Optional: Plugin-specific configuration
   procedure Configure
     (Self : in Out Plugin_Interface;
      Key  : String;
      Value : String) is null;

   --=========================================================================
   -- Language Plugin Interface
   --=========================================================================

   type Language_Plugin_Interface is interface and Plugin_Interface;
   type Language_Plugin_Access is access all Language_Plugin_Interface'Class;

   -- Language metadata
   function Get_Language_Info
     (Self : Language_Plugin_Interface) return Language_Info is abstract;

   -- Source code operations
   function Parse_Source
     (Self   : Language_Plugin_Interface;
      Source : String) return Unbounded_String is abstract;  -- Returns AST as JSON

   function Validate_Syntax
     (Self   : Language_Plugin_Interface;
      Source : String) return Boolean is abstract;

   -- Type checking (if supported)
   function Type_Check
     (Self : Language_Plugin_Interface;
      AST  : String) return Unbounded_String is abstract;  -- Returns typed AST or errors

   -- Execution (if interpreter available)
   function Interpret
     (Self : Language_Plugin_Interface;
      AST  : String) return Unbounded_String is abstract;  -- Returns result

   -- Compilation (if compiler available)
   function Compile
     (Self   : Language_Plugin_Interface;
      AST    : String;
      Target : String) return Unbounded_String is abstract;  -- Returns IR or binary

   -- Aggregate library support
   function Supports_Operation
     (Self : Language_Plugin_Interface;
      Op   : Aggregate_Operation) return Boolean is abstract;

   function Implement_Operation
     (Self : Language_Plugin_Interface;
      Op   : Aggregate_Operation) return Unbounded_String is abstract;  -- Returns implementation

   --=========================================================================
   -- Verification Plugin Interface (for Echidna)
   --=========================================================================

   type Verification_Plugin_Interface is interface and Plugin_Interface;
   type Verification_Plugin_Access is access all Verification_Plugin_Interface'Class;

   -- Supported provers
   type Prover_ID is
     (Agda, Coq, Lean, Isabelle, Z3, CVC5,
      Metamath, HOL_Light, Mizar, PVS, ACL2, HOL4);

   function Supports_Prover
     (Self   : Verification_Plugin_Interface;
      Prover : Prover_ID) return Boolean is abstract;

   -- Proof generation
   function Generate_Proof_Obligation
     (Self     : Verification_Plugin_Interface;
      Property : String;
      Context  : String) return Unbounded_String is abstract;

   function Verify_Property
     (Self     : Verification_Plugin_Interface;
      Property : String;
      Prover   : Prover_ID) return Boolean is abstract;

   -- Test generation
   function Generate_Tests
     (Self         : Verification_Plugin_Interface;
      Specification : String;
      Count        : Positive) return Unbounded_String is abstract;  -- Returns test cases

   -- Type system verification
   function Verify_Type_Soundness
     (Self       : Verification_Plugin_Interface;
      Type_Rules : String;
      Prover     : Prover_ID) return Boolean is abstract;

   --=========================================================================
   -- Library Plugin Interface
   --=========================================================================

   type Library_Plugin_Interface is interface and Plugin_Interface;
   type Library_Plugin_Access is access all Library_Plugin_Interface'Class;

   -- Load standard library
   function Load_Standard_Library
     (Self : Library_Plugin_Interface;
      Path : String) return Boolean is abstract;

   -- Parse into aggregate operations
   function Extract_Aggregate_Operations
     (Self : Library_Plugin_Interface)
      return Unbounded_String is abstract;  -- Returns JSON array of operations

   -- Get operation by name
   function Get_Operation
     (Self : Library_Plugin_Interface;
      Name : String) return Aggregate_Operation is abstract;

   -- List all operations in category
   function List_Operations
     (Self     : Library_Plugin_Interface;
      Category : Aggregate_Category)
      return Unbounded_String is abstract;  -- Returns JSON array

   --=========================================================================
   -- SLM Plugin Interface (Small Language Model)
   --=========================================================================

   type SLM_Plugin_Interface is interface and Plugin_Interface;
   type SLM_Plugin_Access is access all SLM_Plugin_Interface'Class;

   -- Model information
   type SLM_Model_Info is record
      Name           : Unbounded_String;
      Parameters     : Natural;          -- Model size (e.g., 1B, 3B)
      Context_Length : Positive;         -- Max context window
      Quantization   : Unbounded_String; -- e.g., "Q4_K_M", "F16"
      Memory_MB      : Natural;          -- Memory footprint
      Local          : Boolean;          -- Runs locally vs API
   end record;

   function Get_Model_Info
     (Self : SLM_Plugin_Interface) return SLM_Model_Info is abstract;

   -- Direct inference
   function Infer
     (Self   : SLM_Plugin_Interface;
      Prompt : String) return Unbounded_String is abstract;

   function Infer_With_Context
     (Self    : SLM_Plugin_Interface;
      System  : String;
      User    : String;
      Context : String) return Unbounded_String is abstract;

   -- Structured outputs
   function Generate_Code
     (Self        : SLM_Plugin_Interface;
      Language    : Language_ID;
      Description : String) return Unbounded_String is abstract;

   function Analyze_Code
     (Self   : SLM_Plugin_Interface;
      Source : String) return Unbounded_String is abstract;  -- Returns analysis JSON

   function Suggest_Tests
     (Self   : SLM_Plugin_Interface;
      Source : String) return Unbounded_String is abstract;  -- Returns test suggestions

   -- Language-aware operations
   function Explain_For_Age
     (Self    : SLM_Plugin_Interface;
      Concept : String;
      Age     : Positive) return Unbounded_String is abstract;

   function Translate_Between_Dialects
     (Self   : SLM_Plugin_Interface;
      Source : String;
      From   : Language_ID;
      To     : Language_ID) return Unbounded_String is abstract;

end AOLDI.Plugins;
