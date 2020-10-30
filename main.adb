with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Bubble_Sort;
with Quick_Sort;
with Sort_Types; use Sort_Types;

procedure Main is
   A : Nat_Array (1 .. 6) := (2, 5, 4, 9, 1, 3);
   B : Nat_Array (1 .. 6) := (2, 5, 4, 9, 1, 3);
begin
   for X of A loop
       Ada.Integer_Text_IO.Put (X);
   end loop;
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put_Line ("Bubble Sort!");
   Bubble_Sort.Sort (A);
   for X of A loop
       Ada.Integer_Text_IO.Put (X);
   end loop;
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put_Line ("Quick Sort!");
   Quick_Sort.Sort (B);
   for X of B loop
       Ada.Integer_Text_IO.Put (X);
   end loop;

end Main;
