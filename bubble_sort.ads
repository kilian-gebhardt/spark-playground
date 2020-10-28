package Bubble_Sort with
   SPARK_Mode
is
   type Nat_Array is array (Integer range <>) of Natural;
   procedure Sort (L : in out Nat_Array) with
      Post =>
      (for all I in L'Range => (if I < L'Last then L (I) <= L (I + 1)));
end Bubble_Sort;
