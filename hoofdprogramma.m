%% Opdracht 3

n = 8;

% Genereer een willekeurige onderdriehoeksmatrix 
% met diagonaalelementen gelijk aan 1.

L = rand(n);
for i = 1:n
    L(i, i) = 1;
    for j = i+1:n
        L(i, j) = 0;
    end
end

% Genereer een willekeurige bovendriehoeksmatrix.
U = rand(n);
for j = 1:n
    for i = j+1:n
        U(i, j) = 0;
    end
end

A = L * U;

[test_L, test_U] = lu_decomp(A);

tolerantie = 1e-12;

% equivalent: assert(all(ismembertol(L, test_L, tolerantie) == 1, [1 2])
assert(isequal(ones(n), ismembertol(L, test_L, tolerantie)));
assert(isequal(ones(n), ismembertol(U, test_U, tolerantie)));

fprintf('Opdracht 3: test OK\n')

%% Opdracht 5

clear;
test_U = [1 2 3; 0 4 5; 0 0 6];
test_b = [1 4 9];
verwachte_y = [-1.75 -0.875 1.5];

assert(all(ismembertol(solve_Ub(test_U, test_b), verwachte_y) == 1));

test_L = [1 0 0; 1 2 0; 3 5 8];
test_b = [3 1 4];
verwachte_y = [3 -1 0];

assert(all(ismembertol(solve_Lb(test_L, test_b), verwachte_y) == 1));

fprintf('Opdracht 5: test OK\n')

%% Opdracht 6
clear;
n = 5;

[A_1, A_2] = genereer_A_matrices(5)

[L_1, U_1] = lu_decomp(A_1);
[L_2, U_2] = lu_decomp(A_2);

L_1
U_1
L_2
U_2

fprintf('L_1 bevat %d nullen\n', sum(L_1(:) == 0));
fprintf('U_1 bevat %d nullen\n', sum(U_1(:) == 0));
fprintf('L_2 bevat %d nullen\n', sum(L_2(:) == 0));
fprintf('U_2 bevat %d nullen\n', sum(U_2(:) == 0));

%% Opdracht 9

% genereren van de LU-decomposities

all_L1 = list

for i = 1:12
    n = 1000 + i * 500;
    
end