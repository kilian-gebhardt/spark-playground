with Safe_Swap; Use Safe_Swap;
package body Quick_Sort
with
   SPARK_Mode => On
is
   procedure Sort (A : in out Nat_Array) is
        procedure Sort_Rec(L, R : in Index; Min, Max : in Natural) with 
            Pre => L in A'Range and then R in A'Range and then L < R 
                   and then (for all I in L .. R => A(I) >= Min and A(I) <= Max),
            Post => (for all I in L .. R => (if I < R then A (I) <= A (I + 1))) 
                    and (for all I in A'Range => (if I not in L .. R then A(I) = A'Old(I)))
                    and (for all I in L .. R => A(I) >= Min and A(I) <= Max)
        is
           I, J : Index;
           P : constant Natural := A(L);
           Swapped : Boolean := False with Ghost;
        begin
            I := L;
            J := R;
            Pragma Assert (A(L) = P);
            while I <= J loop
                Pragma Loop_Invariant (for all X in L .. R => A(X) >= Min and A(X) <= Max);
                Pragma Loop_Invariant (for all X in A'Range => (if X not in L .. R then A(X) = A'Loop_Entry(X)));
                Pragma Loop_Invariant (I in L .. R and J in L .. R);
                Pragma Loop_Invariant (for all X in L .. I => (if X < I then A(X) <= P));
                Pragma Loop_Invariant (for all X in J .. R => (if X > J then A(X) >= P));
                Pragma Loop_Invariant (if not Swapped then L = I and then A(I) = P);
                Pragma Loop_Invariant (if Swapped then J < R and L < I);
                while A(I) < P and I < R loop
                    Pragma Loop_Invariant (for all X in L .. R => A(X) >= Min and A(X) <= Max);
                    Pragma Loop_Invariant (for all X in A'Range => (if X not in L .. R then A(X) = A'Loop_Entry(X)));
                    Pragma Loop_Invariant (I in L .. R and J in L .. R);
                    Pragma Loop_Invariant (for all X in L .. I => (if X < I then A(X) <= P));
                    Pragma Loop_Invariant (for all X in J .. R => (if X > J then A(X) >= P));
                    Pragma Loop_Invariant (if not Swapped then L = I and then A(I) = P);
                    Pragma Loop_Invariant (if Swapped then J < R);
                    I := I + 1;
                end loop;
                while A(J) > P and L < J loop
                    Pragma Loop_Invariant (for all X in L .. R => A(X) >= Min and A(X) <= Max);
                    Pragma Loop_Invariant (for all X in A'Range => (if X not in L .. R then A(X) = A'Loop_Entry(X)));
                    Pragma Loop_Invariant (I in L .. R and J in L .. R);
                    Pragma Loop_Invariant (for all X in L .. I => (if X < I then A(X) <= P));
                    Pragma Loop_Invariant (for all X in J .. R => (if X > J then A(X) >= P));
                    Pragma Loop_Invariant (if not Swapped then L = I and then A(I) = P);
                    Pragma Loop_Invariant (if Swapped then J < R);
                    J := J - 1;
                end loop;
                if I <= J then
                    if I < J then
                        Swap(A, I, J);
                        Pragma Assert (A(I) <= P);
                        Pragma Assert (A(J) >= P);
                    else
                        Pragma Assert (I = J);
                        Pragma Assert (If not Swapped then L = I and then A(I) = P and then A(J) = P);
                        Pragma Assert (If Swapped then J < R and L < I);
                        Pragma Assert (A(I) >= P);
                        Pragma Assert (A(J) <= P);
                    end if;
                    Pragma Assert (A(I) <= P);
                    Pragma Assert (A(J) >= P);
                    if I < R then
                        I := I + 1;
                    else
                        exit;
                    end if;
                    Pragma Assert (for all X in L .. I => (if X < I then A(X) <= P));
                    if J > L then
                            J := J - 1;
                    else
                        exit;
                    end if;
                    Swapped := True;
                end if;
            end loop;
            Pragma Assert (J <= I);
            Pragma Assert (I in L .. R and J in L .. R);
            Pragma Assert (for all X in L .. I => (if X < I then A(X) <= P));
            Pragma Assert (for all X in J .. R => (if X > J then A(X) >= P));

            Pragma Assert (for all X in L .. J => A(X) <= P);
            Pragma Assert (for all X in J .. I => (if J < X and X < I then A(X) = P));
            Pragma Assert (for all X in I .. R => A(X) >= P);

            Pragma Assert (for all X in J .. I => (if X < I then A(X) <= A(X + 1)));
            if L < J then
                Sort_Rec(L, J, Min, P);
            end if;
            Pragma Assert (for all X in L .. I => (if X < I then A(X) <= A(X + 1)));
            if I < R then
                Sort_Rec(I, R, P, Max);
            end if;
            Pragma Assert (for all X in L .. R => (if X < R then A(X) <= A(X + 1)));
        end Sort_Rec;
   begin
       if A'First >= A'Last then
           return;
       end if;
       Sort_Rec(A'First, A'Last, Natural'First, Natural'Last);
   end Sort;
end Quick_Sort;
