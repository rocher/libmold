-------------------------------------------------------------------------------
--
--  Mold - Meta-variable Operations for Lean Development (lib) TESTS
--  Copyright (c) 2023 Francesc Rocher <francesc.rocher@gmail.com>
--  SPDX-License-Identifier: MIT
--
-------------------------------------------------------------------------------

with Mold;

package Support is

   --!pp off
   Default_Test_Settings : aliased constant Mold.Settings_Type :=
   (
      Rename_Source    => True,
      Delete_Source    => False,   --  Do not remove source files
      Overwrite        => True,    --  Overwrite destination files
      Defined_Settings => True,
      Action           => Mold.Ignore,
      Alert            => Mold.Warning,
      Abort_On_Error   => True
   );
   --!pp on

   Global_Settings : constant Mold.Settings_Access :=
     Default_Test_Settings'Unrestricted_Access;

   --  These are global Support used for testing. Important thing is to not
   --  to remove source files, except in tests prepared for this.

   function Pretty_Print
     (Errors : Natural; Results : Mold.Results_Access) return String;

   procedure Check_Results (Actual, Expected : Mold.Results_Access);

end Support;