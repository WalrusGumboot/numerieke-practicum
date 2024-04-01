function y = solve_Lb(L, b)
% L: een inverteerbare onderdriehoeksmatrix
% b: het rechterlid
% y: de oplossing van het stelsel Ly = b

n = length(L);
y = zeros(n, 1);

assert(isequal(diag(L) ~= 0, ones(n, 1)))

for k = 1:n
    y(k) = (b(k) - L(k, 1:k) * y(1:k)) / L(k, k);
end

end