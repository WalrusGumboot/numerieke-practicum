function [L, U] = lu_decomp(A)
% A: een inverteerbare matrix
% L: een onderdriehoeksmatrix met diagonaalelementen gelijk aan 1
% U: een bovendriehoeksmatrix

n = length(A);

L = eye(n);
U = zeros(n);

for i = 1:n
    product = L * U;
    U(i, i:end) = A(i, i:end) - product(i, i:end);
    L(i+1:end, i) = ( A(i+1:end, i) - product(i+1:end, i) ) / U(i, i);
end

end