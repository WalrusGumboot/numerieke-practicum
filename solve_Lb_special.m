function [y] = solve_Lb_special( L, b)
% L: een onderdriehoeksmatrix die de bovenstaande
% spaarse structuur heeft
% b: het rechterlid
% y: de oplossing van het stelsel Ly = b
n = length(b);
y = zeros(1, n);
for k=1:n-1
    y(k) = b(k);
end
y(n) = b(n) - L(n, 1:n-1)*b(1:n-1, :);
end
