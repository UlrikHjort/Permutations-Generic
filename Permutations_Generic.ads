-------------------------------------------------------------------------------
--                                                                           --
--                         Permutations Generic                              --
--                                                                           --
--                      Permutations_Generic.adb                             --
--                                                                           --
--                                 SPEC                                      --
--                                                                           --
--                   Copyright (C) 1996 Ulrik Hørlyk Hjort                   --
--                                                                           --
--  Permutations Generic is free software;  you can  redistribute it         --
--  and/or modify it under terms of the  GNU General Public License          --
--  as published  by the Free Software  Foundation;  either version 2,       --
--  or (at your option) any later version.                                   --
--  Permutations Generic is distributed in the hope that it will be          --
--  useful, but WITHOUT ANY WARRANTY;  without even the  implied warranty    --
--  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                  --
--  See the GNU General Public License for  more details.                    --
--  You should have  received  a copy of the GNU General                     --
--  Public License  distributed with Yolk.  If not, write  to  the  Free     --
--  Software Foundation,  51  Franklin  Street,  Fifth  Floor, Boston,       --
--  MA 02110 - 1301, USA.                                                    --
--                                                                           --
-------------------------------------------------------------------------------
generic

   type Item is private;

package Permutations_Generic is

   type Permutations_T is array(Natural range <>, Natural range <>) of Item;
   type List_T is array(Natural range <>) of Item;


  ----------------------------------------------------------------------------
  -- Returns the parity of the permutation Altered genereated from Initial
  --
  -- The method to calculate the parity is:
  --
  -- Initial : ( a b c d e)
  -- Altered : ( c b d e a)
  --
  -- =>
  --
  -- (a c e) (b) (d) = odd x even x even = -1 * 1 * 1 = -1
  --
  -- Does not work for sets with duplicated elements like ( a b a c)
  ----------------------------------------------------------------------------
  function Parity(Initial : List_T; Altered : List_T) return Integer;

  ----------------------------------------------------------------------------
  -- Returns the permutation# Index from the list of Permutations
  --
  --
  ----------------------------------------------------------------------------
  function Get_Permutation(Index : Natural; Permutations : Permutations_T) return List_T;

  ----------------------------------------------------------------------------
  -- Returns a list of permutations in Permutations of List
  --
  --
  ----------------------------------------------------------------------------
  procedure Permute(List : in out List_T; Start_Index : Natural;
                                          Permutations : in out Permutations_T;
                                          Number_Of_Permutations : in out Natural);
end Permutations_Generic;
