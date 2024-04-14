function [y] = solve_Lb_special( L, b)
% L: een onderdriehoeksmatrix die de bovenstaande
% spaarse structuur heeft
% b: het rechterlid
% y: de oplossing van het stelsel Ly = b
n = length(b);
y = zeros(n, 1);
y(1:n-1, :) = b(1:n-1, :);
y(n) = b(n) - L(n, 1:n-1)*b(1:n-1, :);
end
