function [] = lu_decomp_test()

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

fprintf('Test OK\n')

end