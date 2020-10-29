with Sort_Types; use Sort_Types;
with Perm; use Perm;

package Safe_Swap with
    SPARK_Mode => On
is
   procedure Swap(A : in out Nat_Array; I,J: in Index) with
        Pre  => I in A'Range and J in A'Range and I /= J,
        Post => Is_Perm(A, A'Old) and A(I) = A'Old(J) and A(J) = A'Old(I) and 
                (for all K in A'Range => (if K /= I and K /= J then A(K) = A'Old(K)));


   procedure Lemma_Occ_Eq (A, B : Nat_Array; E : Natural) with
       Ghost,
       Global => null,
       Pre  => A = B,
       Post => Occ (A, E) = Occ (B, E);
   
   function Is_Set(A : Nat_Array; I : Index; V : Natural; R : Nat_Array) return Boolean 
   is (R'First = A'First and then
       R'Last = A'Last and then
       R(I) = V and then
       (for all J in A'Range => (if I /= J then R(J) = A (J))))
   with 
           Ghost,
           Pre  => I in A'Range;

   procedure Lemma_Occ_Set(A : Nat_Array; I : Index; V, E : Natural; R : Nat_Array) with
        Ghost,
        Global => null,
        Pre => I in A'Range and then Is_Set(A, I, V, R),
        Post => (if V = A(I) then Occ(R, E) = Occ(A, E)
                elsif V = E then Occ(R, E) = Occ(A, E) + 1
                elsif A(I) = E then Occ(R, E) = Occ(A, E) - 1
                else Occ(R, E) = Occ(A, E));
end Safe_Swap;
