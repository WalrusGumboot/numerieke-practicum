function y = solve_Ub(U, b)
% U: een inverteerbare bovendriehoeksmatrix
% b: het rechterlid
% y: de oplossing van het stelsel Uy = b

n = length(U);
y = zeros(n, 1);

assert(isequal(diag(U) ~= 0, ones(n, 1)))

for k = n:-1:1
    y(k) = (b(k) - U(k, k+1:n) * y(k+1:n)) / U(k, k);
end

end