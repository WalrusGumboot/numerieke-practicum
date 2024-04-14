function [A_1, A_2] = genereer_A_matrices(n)

A_1 = speye(n) * 1.1;
A_1(1, 2:end) = repmat(0.01, [n - 1 1]);
A_1(2:end, 1) = repmat(0.01, [1 n - 1]);

A_2 = speye(n) * 1.1;
A_2(n, 1:n-1) = repmat(0.01, [n - 1 1]);
A_2(1:n-1, n) = repmat(0.01, [1 n - 1]);

end