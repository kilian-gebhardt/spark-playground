with Safe_Swap; use Safe_Swap;

package body Bubble_Sort with
   SPARK_Mode
is
   procedure Sort (L : in out Nat_Array) is
   begin
      --pragma Assert (for all X of L => (for some Y of L => X = Y));
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
                 (for all Y in J .. L'Last => (if Y > J then L (X) <= L(Y))));
            pragma Loop_Invariant
              (for all X in J .. L'Last =>
                 (for all Y in X .. L'Last => (L (X) <= L (Y))));
            pragma Loop_Invariant
              (for all X in L'First .. I => L (X) <= L (I));
            if I < J and then L (I) > L (I + 1) then
               Swap(L, I, I+1);
            end if;
            pragma Assert (if I < J then L (I) <= L (I + 1));
         end loop;
      end loop;
   end Sort;
end Bubble_Sort;
