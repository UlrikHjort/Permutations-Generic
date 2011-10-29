-------------------------------------------------------------------------------
--                                                                           --
--                         Permutations Generic                              --
--                                                                           --
--                      Permutations_Generic.adb                             --
--                                                                           --
--                                 BODY                                      --
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

with Ada.Text_IO; use Ada.Text_IO;

package body Permutations_Generic is

  ----------------------------------------------------------------------------
  -- Rotate the list left
  --
  --
  ----------------------------------------------------------------------------
  procedure Rotate(List : in out List_T; Index : in Natural) is
     Element : constant Item := List(Index);

  begin
     for I in Index .. (List'Length-2) loop
        List(I) := List(I+1);
     end loop;
     List(List'Length-1) := Element;
  end Rotate;

  ----------------------------------------------------------------------------
  --
  --
  --
  ----------------------------------------------------------------------------
--  procedure Print_Permutation(List : List_T) is
--  begin
--     for I in List'First .. List'Last loop
--        Put(Item'Image(List(I)) & " ");
--     end loop;
--  New_Line;
--  end Print_Permutation;


  ----------------------------------------------------------------------------
  -- Returns the index of element in List
  --
  --
  ----------------------------------------------------------------------------
  function IndexOf(List : List_T; Element : Item) return Natural is
     Index : Natural := 0;

  begin
     loop
        exit when List(Index) = Element;
        Index := Index + 1;
     end loop;
     return Index;
  end IndexOf;


  ----------------------------------------------------------------------------
  -- Returns true if Element is in List else False
  --
  --
  ----------------------------------------------------------------------------
  function In_List(List : List_T; Element : Item; Length : Natural) return Boolean is

  begin

     for Index in List'First .. Length loop
        if List(Index) = Element then
           return True;
        end if;
     end loop;
     return False;
  end In_List;


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
  function Parity(Initial : List_T; Altered : List_T) return Integer is
     Signature       : Integer := 1;
     Initial_Index   : Natural := 0;
     Current_Index   : Natural := 0;
     Elements_Used   : Natural := 0;
     Elements        : Natural := 1;
     Used_List       : List_T(Initial'Range);
     Used_Index : Natural := 0;

  begin
     Outer_Loop : loop

        Inner_Loop: loop
          exit Inner_Loop When Initial(Initial_Index) = Altered(Current_Index);
          Used_List(Used_Index) := Altered(Current_Index);
          Used_Index := Used_Index + 1;
          Current_Index := IndexOf(Initial, Altered(Current_Index));
          Elements  := Elements + 1;
        end loop Inner_Loop;


        if Initial_Index = Current_Index then
           -------------------------------
           --Initial Case : ( .... X ....)
           --               ( .... X ....)
           -------------------------------
           Used_List(Used_Index) := Altered(Current_Index);
           Used_Index := Used_Index + 1;
        end if;


           Signature := Signature * (-1) * ((-1) ** (Elements));

         Elements_Used := Elements_Used + Elements;

        Elements := 1;
        exit Outer_Loop When Elements_Used = Initial'Length;

        Inner_Loop_2 : loop
           Initial_Index := Initial_Index + 1;
           exit when not In_List(Used_List,Initial(Initial_Index), Used_Index-1);
        end loop Inner_Loop_2;
        Current_Index := Initial_Index;
     end loop Outer_Loop;
    return Signature;
  end Parity;


  ----------------------------------------------------------------------------
  -- Returns the permutation# Index from the list of Permutations
  --
  --
  ----------------------------------------------------------------------------
  function Get_Permutation(Index : Natural; Permutations : Permutations_T) return List_T is
     List : List_T(Permutations'Range(2));

  begin
     for I in Permutations'Range(2) loop
        List(I) := Permutations(Index,I);
     end loop;

     return List;
  end Get_Permutation;


  ----------------------------------------------------------------------------
  -- Returns a list of permutations in Permutations of List
  --
  --
  ----------------------------------------------------------------------------
  procedure Permute(List : in out List_T; Start_Index : Natural;
                                          Permutations : in out Permutations_T;
                                          Number_Of_Permutations : in out Natural) is

     N       : constant Natural := List'Last;
     Element : Item;

  begin
     for I in List'First .. List'Last loop
       Permutations(Number_Of_Permutations,I) := List(I);
     end loop;

     Number_Of_Permutations := Number_Of_Permutations + 1;
     if Start_Index < N then
        for I in reverse Start_Index .. (N-1) loop -- !!!!
           for J in (I+1) .. N loop
              Element := List(I);
              List(I) := List(J);
              List(J) := Element;
              Permute(List, I+1, Permutations, Number_Of_Permutations);
           end loop;
           Rotate(List,I);
           null;
        end loop;
     end if;
  end Permute;
end Permutations_Generic;
