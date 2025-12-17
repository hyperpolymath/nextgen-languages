-- SPDX-License-Identifier: AGPL-3.0-or-later
-- SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
--
-- AOLDI.Hub - Central Coordination Hub
--
-- The main entry point for the AOLDI system. Coordinates:
--   - Plugin lifecycle management
--   - Cross-language operations
--   - Aggregate library management
--   - SLM access for development assistance
--   - Echidna verification orchestration

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with AOLDI;
with AOLDI.Plugins;
with AOLDI.Registry;

package AOLDI.Hub is

   --=========================================================================
   -- Hub Configuration
   --=========================================================================

   type Hub_Config is record
      -- Paths
      Plugin_Directory    : Unbounded_String;
      Aggregate_Lib_Path  : Unbounded_String;
      Cache_Directory     : Unbounded_String;

      -- SLM Configuration
      SLM_Model_Path      : Unbounded_String;
      SLM_Context_Size    : Positive := 4096;
      SLM_Use_Local       : Boolean := True;  -- Local vs API

      -- Echidna Configuration
      Echidna_Path        : Unbounded_String;
      Default_Prover      : Plugins.Prover_ID := Plugins.Z3;

      -- Behavior
      Auto_Load_Plugins   : Boolean := True;
      Enable_Hot_Reload   : Boolean := False;
      Verbose_Logging     : Boolean := False;
   end record;

   Default_Config : constant Hub_Config :=
     (Plugin_Directory    => To_Unbounded_String ("./plugins"),
      Aggregate_Lib_Path  => To_Unbounded_String ("./aggregate-library"),
      Cache_Directory     => To_Unbounded_String ("./.aoldi-cache"),
      SLM_Model_Path      => To_Unbounded_String ("./models"),
      SLM_Context_Size    => 4096,
      SLM_Use_Local       => True,
      Echidna_Path        => To_Unbounded_String ("./echidna"),
      Default_Prover      => Plugins.Z3,
      Auto_Load_Plugins   => True,
      Enable_Hot_Reload   => False,
      Verbose_Logging     => False);

   --=========================================================================
   -- Central Hub
   --=========================================================================

   type Development_Hub is tagged private;

   -- Lifecycle
   function Create (Config : Hub_Config := Default_Config) return Development_Hub;
   function Initialize (Self : in Out Development_Hub) return Boolean;
   procedure Shutdown (Self : in Out Development_Hub);
   function Is_Running (Self : Development_Hub) return Boolean;

   -- Plugin Management
   function Get_Registry (Self : Development_Hub) return Registry.Plugin_Registry;

   procedure Load_Plugin
     (Self : in Out Development_Hub;
      Path : String);

   procedure Unload_Plugin
     (Self : in Out Development_Hub;
      ID   : Plugin_ID);

   --=========================================================================
   -- Cross-Language Operations
   --=========================================================================

   -- Get language status across all loaded plugins
   function Get_Ecosystem_Status
     (Self : Development_Hub) return Unbounded_String;  -- JSON

   -- Find which languages support a given aggregate operation
   function Find_Operation_Implementations
     (Self : Development_Hub;
      Op   : Aggregate_Operation) return Unbounded_String;  -- JSON array of languages

   -- Translate code between languages in the same family
   function Translate_Source
     (Self   : Development_Hub;
      Source : String;
      From   : Language_ID;
      To     : Language_ID) return Unbounded_String;

   -- Compare implementations across languages
   function Compare_Implementations
     (Self      : Development_Hub;
      Operation : Operation_ID) return Unbounded_String;  -- Comparison report

   --=========================================================================
   -- Aggregate Library Operations
   --=========================================================================

   -- Load and parse standard library into aggregate form
   function Load_Aggregate_Library
     (Self : in Out Development_Hub;
      Path : String) return Boolean;

   -- Get all operations
   function Get_Aggregate_Operations
     (Self : Development_Hub) return Unbounded_String;  -- JSON

   -- Get operations by category
   function Get_Operations_By_Category
     (Self     : Development_Hub;
      Category : Aggregate_Category) return Unbounded_String;

   -- Parse a standard library and extract aggregate-compatible operations
   function Parse_Standard_Library
     (Self     : Development_Hub;
      Language : Language_ID;
      Path     : String) return Unbounded_String;  -- Extracted operations

   --=========================================================================
   -- Verification Operations (Echidna Integration)
   --=========================================================================

   -- Verify type system soundness for a language
   function Verify_Type_System
     (Self     : Development_Hub;
      Language : Language_ID) return Unbounded_String;  -- Verification report

   -- Generate tests from specifications
   function Generate_Language_Tests
     (Self     : Development_Hub;
      Language : Language_ID;
      Count    : Positive) return Unbounded_String;  -- Test cases

   -- Verify property across all supporting provers
   function Verify_Property_Multi
     (Self     : Development_Hub;
      Property : String;
      Context  : String) return Unbounded_String;  -- Multi-prover results

   --=========================================================================
   -- SLM Operations (Direct Access)
   --=========================================================================

   -- Direct SLM inference
   function SLM_Query
     (Self   : Development_Hub;
      Prompt : String) return Unbounded_String;

   -- Context-aware query
   function SLM_Query_With_Context
     (Self    : Development_Hub;
      System  : String;
      User    : String;
      Context : String := "") return Unbounded_String;

   -- Code generation
   function SLM_Generate_Code
     (Self        : Development_Hub;
      Language    : Language_ID;
      Description : String) return Unbounded_String;

   -- Code analysis
   function SLM_Analyze_Code
     (Self   : Development_Hub;
      Source : String) return Unbounded_String;

   -- Educational content generation
   function SLM_Explain_Concept
     (Self    : Development_Hub;
      Concept : String;
      Age     : Positive) return Unbounded_String;

   -- Cross-dialect translation assistance
   function SLM_Assist_Translation
     (Self   : Development_Hub;
      Source : String;
      From   : Language_ID;
      To     : Language_ID) return Unbounded_String;

   --=========================================================================
   -- Development Coordination
   --=========================================================================

   -- Suggest next development focus based on completion status
   function Suggest_Development_Priority
     (Self : Development_Hub) return Unbounded_String;

   -- Find patterns across mature implementations
   function Extract_Patterns
     (Self    : Development_Hub;
      Pattern : String) return Unbounded_String;

   -- Check consistency across My-Language family
   function Check_Dialect_Consistency
     (Self : Development_Hub) return Unbounded_String;

private

   type Development_Hub is tagged record
      Config         : Hub_Config;
      Plugin_Registry : Registry.Plugin_Registry;
      Running        : Boolean := False;
      Aggregate_Loaded : Boolean := False;
   end record;

end AOLDI.Hub;
