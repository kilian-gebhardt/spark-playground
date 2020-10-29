package body Safe_Swap with
    SPARK_Mode => On
is
    procedure Swap(A : in out Nat_Array; I, J : in Index) is
        TMP : constant Natural := A(I);
        Init : constant Nat_Array (A'Range):= A with Ghost;
        Interm : Nat_Array (A'Range) with Ghost;

        procedure Prove_Perm With
            Ghost,
            Global => (Init, Interm, I, J, A),
            Pre => I in A'Range and then
                   J in A'Range and then
                   Is_Set(Init, I, Init(J), Interm) and then
                   Is_Set(Interm, J, Init(I), A),
            Post => Is_Perm(Init, A)
        is
        begin
            for E in Natural loop
                Lemma_Occ_Set(Init, I, Init(J), E, Interm);
                Lemma_Occ_Set(Interm, J, Init(I), E, A);
                pragma Loop_Invariant
                    (for all F in Natural'First .. E => 
                        (Occ(A, F) = Occ(Init, F)));
            end loop;
        end Prove_Perm;

    begin
        A(I) := A(J);

        pragma Assert (Is_Set(Init, I, Init(J), A));
        
        Interm := A;
        A(J) := TMP;
        pragma Assert (Is_Set(Interm, J, Init(I), A));

        Prove_Perm;
    end Swap;

    procedure Lemma_Occ_Eq (A, B: Nat_Array; E : Natural) is
    begin
        if A'Length = 0 then
            return;
        end if;

        Lemma_Occ_Eq(Remove_Last(A), Remove_Last(B), E);

        if A(A'Last) = E then
            pragma Assert (B(B'Last) = E);
        else
            pragma Assert (B(B'Last) /= E);
        end if;
    end Lemma_Occ_Eq;

    procedure Lemma_Occ_Set(A : Nat_Array; I : Index; V, E : Natural; R : Nat_Array) is
        B : Nat_Array := Remove_Last(A);
    begin
        if A'Length = 0 then
            return;
        end if;

        if I = A'Last then
            Lemma_Occ_Eq(B, Remove_Last(R), E);
        else
            B(I) := V; 
            Lemma_Occ_Eq(Remove_Last(R), B, E);
            Lemma_Occ_Set(Remove_Last(A), I, V, E, B);
        end if;
    end Lemma_Occ_Set; 

end Safe_Swap;
