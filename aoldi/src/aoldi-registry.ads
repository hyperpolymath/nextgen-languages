-- SPDX-License-Identifier: AGPL-3.0-or-later
-- SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
--
-- AOLDI.Registry - Plugin Registry and Discovery
--
-- Manages registration, discovery, and lifecycle of all plugins.
-- Supports hot-loading and dynamic plugin management.

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Hash;
with AOLDI;
with AOLDI.Plugins;

package AOLDI.Registry is

   --=========================================================================
   -- Plugin Registry
   --=========================================================================

   type Plugin_Registry is tagged private;

   -- Registry operations
   function Create return Plugin_Registry;

   procedure Register_Plugin
     (Self   : in out Plugin_Registry;
      Plugin : Plugins.Plugin_Access);

   procedure Unregister_Plugin
     (Self : in Out Plugin_Registry;
      ID   : Plugin_ID);

   function Get_Plugin
     (Self : Plugin_Registry;
      ID   : Plugin_ID) return Plugins.Plugin_Access;

   function Has_Plugin
     (Self : Plugin_Registry;
      ID   : Plugin_ID) return Boolean;

   -- Query by category
   function Get_Language_Plugins
     (Self : Plugin_Registry) return Unbounded_String;  -- JSON array

   function Get_Verification_Plugins
     (Self : Plugin_Registry) return Unbounded_String;

   function Get_Library_Plugins
     (Self : Plugin_Registry) return Unbounded_String;

   function Get_SLM_Plugins
     (Self : Plugin_Registry) return Unbounded_String;

   -- Lifecycle management
   procedure Initialize_All (Self : in Out Plugin_Registry);
   procedure Shutdown_All (Self : in Out Plugin_Registry);

   -- Status reporting
   function Get_Status (Self : Plugin_Registry) return Unbounded_String;  -- JSON status

private

   package Plugin_Maps is new Ada.Containers.Indefinite_Hashed_Maps
     (Key_Type        => String,
      Element_Type    => Plugins.Plugin_Access,
      Hash            => Ada.Strings.Hash,
      Equivalent_Keys => "=");

   type Plugin_Registry is tagged record
      Plugins      : Plugin_Maps.Map;
      Initialized  : Boolean := False;
   end record;

end AOLDI.Registry;
