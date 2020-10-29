with Sort_Types; use Sort_Types;

package Bubble_Sort with
   SPARK_Mode => On
is
   procedure Sort (L : in out Nat_Array) with
        Global => null
      , Depends => (L => L)
      , Pre => (for all X of L => (for some Y of L => X = Y))
      , Post =>
        (for all I in L'Range => (if I < L'Last then L (I) <= L (I + 1)))
      ;
end Bubble_Sort;
