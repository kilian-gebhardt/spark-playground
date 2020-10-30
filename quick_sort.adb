with Safe_Swap; Use Safe_Swap;
package body Quick_Sort
with
   SPARK_Mode => On
is
   procedure Sort (A : in out Nat_Array) is
        procedure Sort_Rec(L, R : in Index) with 
            Pre => L in A'Range and R in A'Range and L < R,
            Post => (for all I in L .. R => (if I < R then A (I) <= A (I + 1))) 
                    and (for all I in A'Range => (if I not in L .. R then A(I) = A'Old(I)))
        is
           I, J : Index;
           Flag : Boolean := False;
           P : constant Natural := A(L);
        begin
            I := L;
            J := R;

            while I <= J loop
                Pragma Assert (Flag = False);
                Pragma Loop_Invariant (I in L .. R and J in L .. R);
                Pragma Loop_Invariant (for all X in L .. I => (if X < I then A(X) <= P));
                Pragma Loop_Invariant (for all X in J .. R => (if X > J then A(X) >= P));
                while A(I) < P loop
                    Pragma Loop_Invariant (I in L .. R and J in L .. R);
                    Pragma Loop_Invariant (for all X in L .. I => (if X < I then A(X) <= P));
                    Pragma Loop_Invariant (for all X in J .. R => (if X > J then A(X) >= P));
                    Pragma Loop_Invariant (Flag = False or I = R);
                    if I < R then
                        I := I + 1;
                    else
                        Pragma Assert (I = R);
                        Flag := True;
                        exit;
                    end if;
                end loop;
                if Flag then
                    Pragma Assert (I = R);
                    Pragma Assert (J <= I);
                    exit;
                end if;
                while A(J) > P loop
                    Pragma Loop_Invariant (I in L .. R and J in L .. R);
                    Pragma Loop_Invariant (for all X in L .. I => (if X < I then A(X) <= P));
                    Pragma Loop_Invariant (for all X in J .. R => (if X > J then A(X) >= P));
                    if J > L then
                       J := J - 1;
                    else
                        Flag := True;
                        exit;
                    end if;
                end loop;
                if Flag then
                    Pragma Assert (J = L);
                    Pragma Assert (J <= I);
                    exit;
                end if;
                if I <= J then
                    if I < J then
                        Swap(A, I, J);
                        Pragma Assert (A(I) <= P);
                        Pragma Assert (A(J) >= P);
                    else
                        Pragma Assert (I = J);
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
                end if;
            end loop;
            Pragma Assert (J <= I);
            Pragma Assert (I in L .. R and J in L .. R);
            Pragma Assert (for all X in L .. I => (if X < I then A(X) <= P));
            Pragma Assert (for all X in J .. R => (if X > J then A(X) >= P));

            Pragma Assert (for all X in L .. J => A(X) <= P);
            Pragma Assert (for all X in J .. I => (if J < X and X < I then A(X) = P));
            Pragma Assert (for all X in I .. R => A(X) >= P);

            if L < J then
                Sort_Rec(L, J);
            end if;
            if I < R then
                Sort_Rec(I, R);
            end if;
        end Sort_Rec;
   begin
       if A'First >= A'Last then
           return;
       end if;
       Sort_Rec(A'First, A'Last);
   end Sort;
end Quick_Sort;
