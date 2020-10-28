with Ada.Text_IO;
with Ada.Integer_Text_IO;

package body Bubble_Sort with
   SPARK_Mode
is
   procedure Sort (L : in out Nat_Array) is
      TMP : Natural;
   begin
      Ada.Text_IO.Put_Line ("Bubble Sort!");
      for I in L'Range loop
         Ada.Integer_Text_IO.Put (L (I));
      end loop;
      Ada.Text_IO.New_Line;
      for J in reverse L'Range loop
         pragma Loop_Invariant
           (for all X in L'First .. J =>
              (for all Y in J .. L'Last => (if Y > J then L (X) <= L (Y))));
         pragma Loop_Invariant
           (for all X in J .. L'Last =>
              (for all Y in X .. L'Last => (L (X) <= L (Y))));
         for I in L'First .. J loop
            pragma Loop_Invariant
              (for all X in L'First .. J =>
                 (for all Y in J .. L'Last => (if Y > J then L (X) <= L (Y))));
            pragma Loop_Invariant
              (for all X in J .. L'Last =>
                 (for all Y in X .. L'Last => (L (X) <= L (Y))));
            pragma Loop_Invariant
              (for all X in L'First .. I => L (X) <= L (I));
            if I < J and then L (I) > L (I + 1) then
               TMP       := L (I + 1);
               L (I + 1) := L (I);
               L (I)     := TMP;
            end if;
            pragma Assert (if I < J then L (I) <= L (I + 1));
         end loop;
      end loop;
      for I in L'Range loop
         Ada.Integer_Text_IO.Put (L (I));
      end loop;
   end Sort;
end Bubble_Sort;
