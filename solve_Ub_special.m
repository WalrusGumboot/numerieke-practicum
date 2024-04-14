function y = solve_Ub_special(U, b)
% U: een bovendriehoeksmatrix die de bovenstaande
% spaarse structuur heeft
% b: het rechterlid
% y: de oplossing van het stelsel Uy = b

n = length(b);

y = zeros(1, n);

y(n) = b(end)/U(end, end);
delingsfactor = U(1, 1);
vermenigv_factor = U(1, end);

for k = n-1:-1:1
    y(k) = (b(k) - vermenigv_factor * y(n)) / delingsfactor;
end


end