-- SPDX-License-Identifier: AGPL-3.0-or-later
-- SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
--
-- Plugin_Betlang - betlang Language Plugin for AOLDI
--
-- betlang is a ternary probabilistic programming language built on Racket.
-- Status: 95% complete (180+ functions, production-ready)
--
-- This plugin provides:
--   - Integration with the Racket runtime
--   - Probabilistic operation support
--   - Full aggregate library coverage

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with AOLDI;
with AOLDI.Plugins;

package Plugin_Betlang is

   type Betlang_Plugin is new AOLDI.Plugins.Language_Plugin_Interface with private;

   -- Plugin Interface implementation
   overriding function Get_Info
     (Self : Betlang_Plugin) return AOLDI.Plugin_Info;
   overriding function Initialize
     (Self : in Out Betlang_Plugin) return Boolean;
   overriding procedure Shutdown
     (Self : in Out Betlang_Plugin);
   overriding function Is_Ready
     (Self : Betlang_Plugin) return Boolean;

   -- Language Plugin Interface implementation
   overriding function Get_Language_Info
     (Self : Betlang_Plugin) return AOLDI.Language_Info;
   overriding function Parse_Source
     (Self : Betlang_Plugin; Source : String) return Unbounded_String;
   overriding function Validate_Syntax
     (Self : Betlang_Plugin; Source : String) return Boolean;
   overriding function Type_Check
     (Self : Betlang_Plugin; AST : String) return Unbounded_String;
   overriding function Interpret
     (Self : Betlang_Plugin; AST : String) return Unbounded_String;
   overriding function Compile
     (Self : Betlang_Plugin; AST : String; Target : String) return Unbounded_String;
   overriding function Supports_Operation
     (Self : Betlang_Plugin; Op : AOLDI.Aggregate_Operation) return Boolean;
   overriding function Implement_Operation
     (Self : Betlang_Plugin; Op : AOLDI.Aggregate_Operation) return Unbounded_String;

   -- betlang-specific operations
   function Create_Ternary_Bet
     (Self : Betlang_Plugin;
      A, B, C : String) return Unbounded_String;

   function Run_MCMC
     (Self    : Betlang_Plugin;
      Model   : String;
      Samples : Positive) return Unbounded_String;

   function Get_Racket_Path
     (Self : Betlang_Plugin) return String;

private

   type Betlang_Plugin is new AOLDI.Plugins.Language_Plugin_Interface with record
      Racket_Path    : Unbounded_String;
      Initialized    : Boolean := False;
      REPL_Available : Boolean := False;
   end record;

end Plugin_Betlang;
