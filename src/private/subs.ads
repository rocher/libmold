-------------------------------------------------------------------------------
--
--  Mold - Meta-variable Operations for Lean Development (lib)
--  Copyright (c) 2023 Francesc Rocher <francesc.rocher@gmail.com>
--  SPDX-License-Identifier: MIT
--
-------------------------------------------------------------------------------

with Ada.Containers.Hashed_Maps; use Ada.Containers;
with Ada.Strings.Unbounded;      use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Hash;

with Mold;

package Subs is

   package Variables_Package is new Hashed_Maps
     (Key_Type => Unbounded_String, Element_Type => Unbounded_String,
      Hash => Ada.Strings.Unbounded.Hash, Equivalent_Keys => "=", "=" => "=");

   subtype Variables_Map is Variables_Package.Map;
   type Variables_Access is access all Variables_Map;

   function Read_Variables_Map
     (Vars_File : String; Results : Mold.Results_Access) return Variables_Map;
   --
   --  Read all variables definition of the given TOML Vars_File. Return a
   --  Variables_Map object.
   --  ------------------------------------------------------------------------

   function Replace
   --!pp off
   (
      Source    : String;
      Variables : Variables_Access;
      Settings  : Mold.Settings_Access;
      Results   : Mold.Results_Access
   )
   --!pp on

      return Natural;
   --
   --  Replace all occurrences of variables defined in Variables in all files
   --  with extension "mold" in the Source file or directory. For all
   --  directories found, apply the same operation except for ".", ".." and
   --  ".git" directories.
   --
   --  Return the number of errors detected.
   --  ------------------------------------------------------------------------

   procedure Inc (Results : Mold.Results_Access; Field : Mold.Field_Type);
   --  Increment results field.

end Subs;
