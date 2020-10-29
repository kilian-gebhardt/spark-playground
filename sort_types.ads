package Sort_Types with SPARK_Mode is
   type Index is range Integer'First + 1 .. Integer'Last;
   type Nat_Array is array (Index range <>) of Natural;
end Sort_Types;
