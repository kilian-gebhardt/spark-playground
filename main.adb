with Ada.Text_IO;
with Bubble_Sort; use Bubble_Sort;

procedure Main is
   A : Nat_Array (1 .. 6) := (2, 5, 4, 9, 1, 3);
begin
   Ada.Text_IO.Put_Line ("Hello World!");
   Sort (A);

   Ada.Text_IO.New_Line;
end Main;
