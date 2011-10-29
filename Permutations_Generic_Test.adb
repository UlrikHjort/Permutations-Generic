-------------------------------------------------------------------------------
--                                                                           --
--                        Permutations Generic                               --
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
with Number_Theory_Tools; use Number_Theory_Tools;
with Permutations_Generic;
with Ada.Text_IO; use Ada.Text_IO;

procedure Permutations_Generic_Test is

   package Permutations_Natural is new Permutations_Generic(Natural);
   package Permutations_Float is new Permutations_Generic(Float);
   package Permutations_Character is new Permutations_Generic(Character);

   Float_List   : Permutations_Float.List_T := (1.0,2.0,3.0,4.0,5.0);
   Float_A_List : Permutations_Float.List_T := (3.0,4.0,5.0,2.0,1.0);

   Natural_List   : Permutations_Natural.List_T := (1,2,3,4,5);
   Natural_A_List : Permutations_Natural.List_T := (3,4,5,2,1);

   Char_List   : Permutations_Character.List_T := ('a','b','c','d');
   Char_A_List : Permutations_Character.List_T := ('c','a','d','b');


   Permutation_Natural : Permutations_Natural.Permutations_T(0 .. Natural(Factorial(Natural_List'Length)),Natural_List'Range);
   Permutation_Float : Permutations_Float.Permutations_T(0 .. Natural(Factorial(Float_List'Length)),Float_List'Range);
   Permutation_Character : Permutations_Character.Permutations_T(0 .. Natural(Factorial(Char_List'Length)),Char_List'Range);

   Number_Of_Permutations : Natural := 0;

begin

   Put_Line("**************************************************** Natural test:");
   Put_Line("Sign : " & Integer'Image(Permutations_Natural.Parity(Natural_List, Natural_A_List)));

   Permutations_Natural.Permute(Natural_List,0, Permutation_Natural,Number_Of_Permutations);
        for I in Permutation_Natural'First .. Permutation_Natural'Last-1 loop
           Natural_List := Permutations_Natural.Get_Permutation(I, Permutation_Natural);
             for II in Natural_List'First .. Natural_List'Last loop
                Put(Integer'Image(Natural_List(II)) & " ");
             end loop;
             New_Line;
     end loop;
     New_Line;


   Put_Line("**************************************************** Float test:");
   Number_Of_Permutations := 0;
   Put_Line("Sign : " & Integer'Image(Permutations_Float.Parity(Float_List, Float_A_List)));

   Permutations_Float.Permute(Float_List,0, Permutation_Float,Number_Of_Permutations);
        for I in Permutation_Float'First .. Permutation_Float'Last-1 loop
           Float_List := Permutations_Float.Get_Permutation(I, Permutation_Float);
             for II in Float_List'First .. Float_List'Last loop
                Put(Float'Image(Float_List(II)) & " ");
             end loop;
             New_Line;
     end loop;
     New_Line;


   Put_Line("**************************************************** Character test:");
   Number_Of_Permutations := 0;
   Put_Line("Sign : " & Integer'Image(Permutations_Character.Parity(Char_List, Char_A_List)));

   Permutations_Character.Permute(Char_List,0, Permutation_Character,Number_Of_Permutations);
        for I in Permutation_Character'First .. Permutation_Character'Last-1 loop
           Char_List := Permutations_Character.Get_Permutation(I, Permutation_Character);
             for II in Char_List'First .. Char_List'Last loop
                Put(Character'Image(Char_List(II)) & " ");
             end loop;
             New_Line;
     end loop;
     New_Line;


end Permutations_Generic_Test;
