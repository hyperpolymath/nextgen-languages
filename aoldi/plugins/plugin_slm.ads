-- SPDX-License-Identifier: AGPL-3.0-or-later
-- SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
--
-- Plugin_SLM - Small Language Model Plugin for AOLDI
--
-- Provides direct access to a local SLM for:
--   - Code generation and analysis
--   - Educational content generation
--   - Cross-dialect translation assistance
--   - Development prioritization suggestions
--
-- Supports local inference (llama.cpp) and API fallback (Claude)

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with AOLDI;
with AOLDI.Plugins;

package Plugin_SLM is

   type SLM_Plugin is new AOLDI.Plugins.SLM_Plugin_Interface with private;

   -- Plugin Interface implementation
   overriding function Get_Info
     (Self : SLM_Plugin) return AOLDI.Plugin_Info;
   overriding function Initialize
     (Self : in Out SLM_Plugin) return Boolean;
   overriding procedure Shutdown
     (Self : in Out SLM_Plugin);
   overriding function Is_Ready
     (Self : SLM_Plugin) return Boolean;

   -- SLM Plugin Interface implementation
   overriding function Get_Model_Info
     (Self : SLM_Plugin) return AOLDI.Plugins.SLM_Model_Info;
   overriding function Infer
     (Self : SLM_Plugin; Prompt : String) return Unbounded_String;
   overriding function Infer_With_Context
     (Self : SLM_Plugin; System : String; User : String; Context : String) return Unbounded_String;
   overriding function Generate_Code
     (Self : SLM_Plugin; Language : AOLDI.Language_ID; Description : String) return Unbounded_String;
   overriding function Analyze_Code
     (Self : SLM_Plugin; Source : String) return Unbounded_String;
   overriding function Suggest_Tests
     (Self : SLM_Plugin; Source : String) return Unbounded_String;
   overriding function Explain_For_Age
     (Self : SLM_Plugin; Concept : String; Age : Positive) return Unbounded_String;
   overriding function Translate_Between_Dialects
     (Self : SLM_Plugin; Source : String; From : AOLDI.Language_ID; To : AOLDI.Language_ID) return Unbounded_String;

   --=========================================================================
   -- SLM-Specific Operations
   --=========================================================================

   -- Model management
   function Load_Model
     (Self : in Out SLM_Plugin;
      Path : String) return Boolean;

   function Unload_Model
     (Self : in Out SLM_Plugin) return Boolean;

   function Set_Context_Size
     (Self : in Out SLM_Plugin;
      Size : Positive);

   -- Inference configuration
   procedure Set_Temperature
     (Self : in Out SLM_Plugin;
      Temp : Float);

   procedure Set_Top_P
     (Self : in Out SLM_Plugin;
      P    : Float);

   procedure Set_Max_Tokens
     (Self   : in Out SLM_Plugin;
      Tokens : Positive);

   -- Streaming inference
   type Token_Callback is access procedure (Token : String);

   procedure Infer_Streaming
     (Self     : SLM_Plugin;
      Prompt   : String;
      Callback : Token_Callback);

   --=========================================================================
   -- Language Development Assistance
   --=========================================================================

   -- Pattern extraction from mature implementations
   function Extract_Implementation_Pattern
     (Self    : SLM_Plugin;
      Source  : String;
      Pattern : String) return Unbounded_String;

   -- Suggest improvements based on analysis
   function Suggest_Improvements
     (Self   : SLM_Plugin;
      Source : String;
      Goals  : String) return Unbounded_String;

   -- Generate documentation
   function Generate_Documentation
     (Self   : SLM_Plugin;
      Source : String;
      Style  : String := "technical") return Unbounded_String;

   -- Educational content for My-Language family
   function Generate_Tutorial
     (Self     : SLM_Plugin;
      Topic    : String;
      Dialect  : AOLDI.Language_ID;
      Age      : Positive) return Unbounded_String;

   function Generate_Example
     (Self     : SLM_Plugin;
      Concept  : String;
      Dialect  : AOLDI.Language_ID;
      Complexity : String := "simple") return Unbounded_String;

   --=========================================================================
   -- Development Coordination
   --=========================================================================

   -- Analyze ecosystem status and suggest priorities
   function Analyze_Ecosystem
     (Self   : SLM_Plugin;
      Status : String) return Unbounded_String;  -- Priority recommendations

   -- Compare implementations
   function Compare_Implementations
     (Self     : SLM_Plugin;
      Impl_A   : String;
      Impl_B   : String;
      Language_A : AOLDI.Language_ID;
      Language_B : AOLDI.Language_ID) return Unbounded_String;

   -- Identify missing features
   function Identify_Gaps
     (Self      : SLM_Plugin;
      Language  : AOLDI.Language_ID;
      Reference : String) return Unbounded_String;

   --=========================================================================
   -- API Fallback (Claude)
   --=========================================================================

   procedure Enable_API_Fallback
     (Self    : in Out SLM_Plugin;
      API_Key : String);

   procedure Disable_API_Fallback
     (Self : in Out SLM_Plugin);

   function Is_Using_Local
     (Self : SLM_Plugin) return Boolean;

private

   type SLM_Plugin is new AOLDI.Plugins.SLM_Plugin_Interface with record
      Model_Path     : Unbounded_String;
      Model_Loaded   : Boolean := False;
      Initialized    : Boolean := False;

      -- Model parameters
      Context_Size   : Positive := 4096;
      Temperature    : Float := 0.7;
      Top_P          : Float := 0.9;
      Max_Tokens     : Positive := 1024;

      -- API fallback
      Use_Local      : Boolean := True;
      API_Key        : Unbounded_String;
      Fallback_Enabled : Boolean := False;
   end record;

end Plugin_SLM;
