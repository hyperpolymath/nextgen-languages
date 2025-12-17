-- SPDX-License-Identifier: AGPL-3.0-or-later
-- SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
--
-- AOLDI.Aggregate - Aggregate Library Management
--
-- Handles loading, parsing, and management of the aggregate library
-- (aLib) specification. Supports:
--   - Loading existing aggregate library definitions
--   - Parsing standard libraries into aggregate form
--   - Mapping operations across languages

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
with AOLDI;

package AOLDI.Aggregate is

   --=========================================================================
   -- Aggregate Library Constants
   -- Based on aLib specification: 20 core operations across 6 categories
   --=========================================================================

   -- Arithmetic operations (5)
   Op_Add      : constant Operation_ID := To_Unbounded_String ("add");
   Op_Subtract : constant Operation_ID := To_Unbounded_String ("subtract");
   Op_Multiply : constant Operation_ID := To_Unbounded_String ("multiply");
   Op_Divide   : constant Operation_ID := To_Unbounded_String ("divide");
   Op_Modulo   : constant Operation_ID := To_Unbounded_String ("modulo");

   -- Comparison operations (6)
   Op_Less_Than    : constant Operation_ID := To_Unbounded_String ("less_than");
   Op_Greater_Than : constant Operation_ID := To_Unbounded_String ("greater_than");
   Op_Equal        : constant Operation_ID := To_Unbounded_String ("equal");
   Op_Not_Equal    : constant Operation_ID := To_Unbounded_String ("not_equal");
   Op_Less_Equal   : constant Operation_ID := To_Unbounded_String ("less_equal");
   Op_Greater_Equal : constant Operation_ID := To_Unbounded_String ("greater_equal");

   -- Logical operations (3)
   Op_And : constant Operation_ID := To_Unbounded_String ("and");
   Op_Or  : constant Operation_ID := To_Unbounded_String ("or");
   Op_Not : constant Operation_ID := To_Unbounded_String ("not");

   -- String operations (3)
   Op_Concat    : constant Operation_ID := To_Unbounded_String ("concat");
   Op_Length    : constant Operation_ID := To_Unbounded_String ("length");
   Op_Substring : constant Operation_ID := To_Unbounded_String ("substring");

   -- Collection operations (4)
   Op_Map      : constant Operation_ID := To_Unbounded_String ("map");
   Op_Filter   : constant Operation_ID := To_Unbounded_String ("filter");
   Op_Fold     : constant Operation_ID := To_Unbounded_String ("fold");
   Op_Contains : constant Operation_ID := To_Unbounded_String ("contains");

   -- Conditional operations (1)
   Op_If_Then_Else : constant Operation_ID := To_Unbounded_String ("if_then_else");

   --=========================================================================
   -- Aggregate Library Manager
   --=========================================================================

   type Aggregate_Library is tagged private;

   -- Loading
   function Create return Aggregate_Library;
   function Load_From_Path
     (Self : in Out Aggregate_Library;
      Path : String) return Boolean;
   function Load_From_JSON
     (Self : in Out Aggregate_Library;
      JSON : String) return Boolean;

   -- Query operations
   function Get_Operation
     (Self : Aggregate_Library;
      ID   : Operation_ID) return Aggregate_Operation;

   function Has_Operation
     (Self : Aggregate_Library;
      ID   : Operation_ID) return Boolean;

   function List_All_Operations
     (Self : Aggregate_Library) return Unbounded_String;  -- JSON array

   function List_By_Category
     (Self     : Aggregate_Library;
      Category : Aggregate_Category) return Unbounded_String;

   -- Statistics
   function Operation_Count (Self : Aggregate_Library) return Natural;
   function Category_Count
     (Self     : Aggregate_Library;
      Category : Aggregate_Category) return Natural;

   --=========================================================================
   -- Standard Library Parser
   -- Extracts aggregate-compatible operations from language std libs
   --=========================================================================

   type Library_Parser is tagged private;

   function Create return Library_Parser;

   -- Parse a standard library file/directory
   function Parse_Library
     (Self     : in Out Library_Parser;
      Path     : String;
      Language : Language_ID) return Unbounded_String;  -- Extracted operations JSON

   -- Map parsed operations to aggregate operations
   function Map_To_Aggregate
     (Self   : Library_Parser;
      Parsed : String) return Unbounded_String;  -- Mapping report

   -- Find gaps (aggregate ops not implemented in language)
   function Find_Missing_Operations
     (Self     : Library_Parser;
      Language : Language_ID) return Unbounded_String;  -- Missing ops JSON

   --=========================================================================
   -- Operation Implementation Mapping
   -- Tracks how each language implements aggregate operations
   --=========================================================================

   type Implementation_Record is record
      Language       : Language_ID;
      Operation      : Operation_ID;
      Function_Name  : Unbounded_String;  -- Name in that language
      Signature      : Unbounded_String;  -- Type signature
      Source_File    : Unbounded_String;  -- Where it's defined
      Implementation : Unbounded_String;  -- Actual code
      Test_Coverage  : Completion_Percentage;
   end record;

   package Implementation_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Implementation_Record);

   type Implementation_Map is tagged private;

   function Create return Implementation_Map;

   procedure Add_Implementation
     (Self   : in Out Implementation_Map;
      Record : Implementation_Record);

   function Get_Implementations
     (Self : Implementation_Map;
      Op   : Operation_ID) return Unbounded_String;  -- All implementations of op

   function Get_Language_Coverage
     (Self     : Implementation_Map;
      Language : Language_ID) return Unbounded_String;  -- Which ops language covers

   function Get_Coverage_Matrix
     (Self : Implementation_Map) return Unbounded_String;  -- Full matrix as JSON

private

   package Operation_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Aggregate_Operation);

   type Aggregate_Library is tagged record
      Operations : Operation_Vectors.Vector;
      Loaded     : Boolean := False;
      Source_Path : Unbounded_String;
   end record;

   type Library_Parser is tagged record
      Current_Language : Language_ID;
      Parsed_Count     : Natural := 0;
   end record;

   type Implementation_Map is tagged record
      Implementations : Implementation_Vectors.Vector;
   end record;

end AOLDI.Aggregate;
