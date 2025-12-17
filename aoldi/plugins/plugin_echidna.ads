-- SPDX-License-Identifier: AGPL-3.0-or-later
-- SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
--
-- Plugin_Echidna - Echidna Verification Plugin for AOLDI
--
-- Echidna is a neurosymbolic theorem proving platform supporting 12 provers:
--   Agda, Coq, Lean, Isabelle, Z3, CVC5, Metamath, HOL Light, Mizar, PVS, ACL2, HOL4
--
-- This plugin provides:
--   - Type system soundness verification
--   - Property-based test generation
--   - Formal verification of language semantics
--   - Cross-prover verification orchestration

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with AOLDI;
with AOLDI.Plugins;

package Plugin_Echidna is

   type Echidna_Plugin is new AOLDI.Plugins.Verification_Plugin_Interface with private;

   -- Plugin Interface implementation
   overriding function Get_Info
     (Self : Echidna_Plugin) return AOLDI.Plugin_Info;
   overriding function Initialize
     (Self : in Out Echidna_Plugin) return Boolean;
   overriding procedure Shutdown
     (Self : in Out Echidna_Plugin);
   overriding function Is_Ready
     (Self : Echidna_Plugin) return Boolean;

   -- Verification Plugin Interface implementation
   overriding function Supports_Prover
     (Self : Echidna_Plugin; Prover : AOLDI.Plugins.Prover_ID) return Boolean;
   overriding function Generate_Proof_Obligation
     (Self : Echidna_Plugin; Property : String; Context : String) return Unbounded_String;
   overriding function Verify_Property
     (Self : Echidna_Plugin; Property : String; Prover : AOLDI.Plugins.Prover_ID) return Boolean;
   overriding function Generate_Tests
     (Self : Echidna_Plugin; Specification : String; Count : Positive) return Unbounded_String;
   overriding function Verify_Type_Soundness
     (Self : Echidna_Plugin; Type_Rules : String; Prover : AOLDI.Plugins.Prover_ID) return Boolean;

   --=========================================================================
   -- Echidna-Specific Operations
   --=========================================================================

   -- Prover management
   function Get_Available_Provers
     (Self : Echidna_Plugin) return Unbounded_String;  -- JSON array

   function Get_Prover_Status
     (Self   : Echidna_Plugin;
      Prover : AOLDI.Plugins.Prover_ID) return Unbounded_String;

   -- Multi-prover verification
   function Verify_With_All_Provers
     (Self     : Echidna_Plugin;
      Property : String;
      Context  : String) return Unbounded_String;  -- Results from each prover

   function Verify_With_Best_Prover
     (Self     : Echidna_Plugin;
      Property : String;
      Category : String) return Unbounded_String;  -- Auto-select best prover

   -- Language-specific verification
   function Verify_Language_Semantics
     (Self     : Echidna_Plugin;
      Language : AOLDI.Language_ID;
      Semantics : String) return Unbounded_String;

   function Verify_Type_Progress
     (Self       : Echidna_Plugin;
      Type_Rules : String) return Boolean;  -- Progress theorem

   function Verify_Type_Preservation
     (Self       : Echidna_Plugin;
      Type_Rules : String) return Boolean;  -- Preservation theorem

   -- Test generation
   function Generate_Property_Tests
     (Self       : Echidna_Plugin;
      Properties : String;
      Count      : Positive) return Unbounded_String;

   function Generate_Counterexamples
     (Self     : Echidna_Plugin;
      Property : String) return Unbounded_String;

   -- Neural-symbolic integration
   function Neural_Proof_Synthesis
     (Self   : Echidna_Plugin;
      Goal   : String;
      Hints  : String := "") return Unbounded_String;  -- Synthesized proof

   function Symbolic_Verification
     (Self  : Echidna_Plugin;
      Proof : String;
      Prover : AOLDI.Plugins.Prover_ID) return Boolean;

   --=========================================================================
   -- Prover-Specific Interfaces
   --=========================================================================

   -- Agda interface
   function Generate_Agda_Module
     (Self       : Echidna_Plugin;
      Type_Rules : String) return Unbounded_String;

   -- Coq interface
   function Generate_Coq_Proof
     (Self     : Echidna_Plugin;
      Property : String) return Unbounded_String;

   -- Z3 interface
   function Generate_SMT_Query
     (Self     : Echidna_Plugin;
      Property : String) return Unbounded_String;

   function Check_SMT_Satisfiability
     (Self  : Echidna_Plugin;
      Query : String) return Boolean;

private

   type Prover_Status_Array is array (AOLDI.Plugins.Prover_ID) of Boolean;

   type Echidna_Plugin is new AOLDI.Plugins.Verification_Plugin_Interface with record
      Echidna_Path     : Unbounded_String;
      Initialized      : Boolean := False;
      Available_Provers : Prover_Status_Array := (others => False);
   end record;

end Plugin_Echidna;
