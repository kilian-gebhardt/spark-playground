with Sort_Types; use Sort_Types;

package Quick_Sort with
   SPARK_Mode => On
is
   procedure Sort (A : in out Nat_Array) with
        Global => null
      , Depends => (A => A)
      , Pre => (for all X of A => (for some Y of A => X = Y))
      , Post =>
        (for all I in A'Range => (if I < A'Last then A (I) <= A (I + 1)))
      ;
end Quick_Sort;
