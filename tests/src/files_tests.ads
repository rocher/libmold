-------------------------------------------------------------------------------
--
--  Mold - Meta-variable Operations for Lean Development (lib) TESTS
--  Copyright (c) 2023 Francesc Rocher <francesc.rocher@gmail.com>
--  SPDX-License-Identifier: MIT
--
-------------------------------------------------------------------------------

with AUnit;            use AUnit;
with AUnit.Test_Cases; use AUnit.Test_Cases;

package Files_Tests is

   type Files_Test_Case is new Test_Case with null record;

   overriding function Name (T : Files_Test_Case) return Message_String;

   overriding procedure Register_Tests (T : in out Files_Test_Case);

   procedure Test_No_Renaming (T : in out Test_Case'Class);
   procedure Test_Basic_Renaming (T : in out Test_Case'Class);

end Files_Tests;
