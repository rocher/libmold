-------------------------------------------------------------------------------
--
--  Mold_Lib - Meta-variable Operations for Lean Development
--  Copyright (c) 2023 Francesc Rocher <francesc.rocher@gmail.com>
--  SPDX-License-Identifier: MIT
--
-------------------------------------------------------------------------------
--!pp off
--
--  Please visit  https://rocher.github.io/mold  for a complete reference.
--

with Custom_Text_Filters;
with Simple_Logging;

package Mold_Lib is

   package Log renames Simple_Logging;

   type Undefined_Alerts is (None, Warning, Error);
   --  Error level to assume when undefined variables or text filters are
   --  encountered during the variable substitution process.

   type Undefined_Actions is (Ignore, Empty);
   --  Action to perform when an undefined variable or text filter is found.
   --  'Ignore' means that there is no substitution at all, and the same
   --  variable substitution will appear (e.g. '{{My_Var}}'). 'Empty' will
   --  completely remove the variable (empty string).

   type Settings_Type is record
      Replacement_In_Filenames    : aliased Boolean;
      Delete_Source_Files         : aliased Boolean;
      Overwrite_Destination_Files : aliased Boolean;
      Enable_Defined_Settings     : aliased Boolean;
      Undefined_Action            : aliased Undefined_Actions;
      Undefined_Alert             : aliased Undefined_Alerts;
   end record;
   type Settings_Access is access all Settings_Type;
   --  Settings to configure the behavior of mold. Refer to the documentation
   --  for more information.

   Default_Settings : constant Settings_Type := (
      Replacement_In_Filenames    => True,
      Delete_Source_Files         => False,
      Overwrite_Destination_Files => True,
      Enable_Defined_Settings     => True,
      Undefined_Action            => Ignore,
      Undefined_Alert             => Warning
   );

   type Results_Fields is (
      Files_Processed,
      Files_Renamed,
      Files_Overwritten,
      Files_Deleted,
      Variables_Defined,
      Variables_Found,
      Variables_Undefined,
      Variables_Replaced,
      Variables_Ignored,
      Variables_Emptied,
      Warnings
   );
   type Results_Type   is array (Results_Fields) of Natural;
   type Results_Access is access all Results_Type;
   --  Set of results returned by mold, when requested.

   subtype Filters_Array  is Custom_Text_Filters.Filters_Array;
   subtype Filters_Access is Custom_Text_Filters.Filters_Access;
   --  Text filters are pointers to functions with the specification:
   --
   --     function (S : String) return String;
   --
   --  that can be applied during variable substitution to provide additional
   --  text transformation. There are several predefined text filters covering
   --  a wide range of use cases. In case you need to define your custom text
   --  filter, you can provide up to ten functions with the above
   --  specification. The type Filter_Access is a pointer to an array of ten
   --  (0 .. 9) pointers to functions.

   function Name return String;

   function Version return String;

   function Apply (
      Source     : String          := ".";
      Output_Dir : String          := "";
      Toml_File  : String          := "mold.toml";
      Settings   : Settings_Access := null;
      Filters    : Filters_Access  := null;
      Results    : Results_Access  := null;
      Log_Level  : Log.Levels      := Log.Info
   )  return Boolean;
   --  Given Source, a file or directory, a TOML file with a set of variables
   --  defined in it, this function applies variable replacement and template
   --  inclusion in Source file. Or, recursively, in all '.mold' files in the
   --  current directory and subdirectories when Source is a directory.
   --  Optionally, Output_Dir can specify a different output directory,
   --  Settings can be a customized set  of settings other than
   --  Default_Settings, and Results can be a pointer to a Results_Type object
   --  if detailed information about the process is required.
   --
   --  Return True if the process ends successfully (no errors detected).

end Mold_Lib;
