function [L, U] = lu_decomp(A)
% A: een inverteerbare matrix
% L: een onderdriehoeksmatrix met diagonaalelementen gelijk aan 1
% U: een bovendriehoeksmatrix

n = length(A);

L = eye(n);
U = zeros(n);


for i = 1:n
    % eerste scamversie met veel for loops
    for k = i:n
        tmp = 0;
        for j = 1:i-1
            tmp = tmp + L(i, j) * U(j, k);
        end
        U(i, k) = A(i, k) - tmp;
    end

    for k = i+1:n
        tmp = 0;
        for j = 1:i-1
            tmp = tmp + L(k, j) * U(j, i);
        end
        L(k, i) = (A(k, i) - tmp) / U(i, i);
    end
end

end