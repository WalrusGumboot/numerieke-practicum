function [L, U] = incompl_lu_decomp(A)
% A: een inverteerbare matrix
% L: een onderdriehoeksmatrix met diagonaalelementen gelijk aan 1
% U: een bovendriehoeksmatrix

assert(det(A) ~= 0, "Matrix is niet inverteerbaar.")

n = length(A);

L = speye(n);
U = sparse(n, n);

for i = 1:n
    product = L * U;

    nullen_op_ide_rij = A(:, i) ~= 0;
    nullen_op_ide_kolom = A(i, :) ~= 0;

    U(i, i:end) = (A(i, i:end) - product(i, i:end)) .* nullen_op_ide_kolom(i:end);
    L(i+1:end, i) = (( A(i+1:end, i) - product(i+1:end, i) ) / U(i, i)) .* nullen_op_ide_rij(i+1:end);
end

end