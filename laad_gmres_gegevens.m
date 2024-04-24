function [x0, x1, resvec0, resvec1, cond_voor, cond_na] = laad_gmres_gegevens(pad)
load(pad, "A")

b = ones(length(A), 1);

[x0, ~, ~, ~, resvec0] = gmres(A, b);
[L, U] = incompl_lu_decomp(A);
[y_1,  ~, ~, ~, resvec1] = gmres(@(x) A * (solve_Ub(U, solve_Lb(L, x))), b);
x1 = solve_Ub(U, solve_Lb(L, y_1));
M = L*U;

cond_voor = condest(A);
cond_na = condest(A * M^-1);

fprintf("conditiegetal zonder preconditionering: %d\n", cond_voor);
fprintf("conditiegetal met preconditionering: %d\n", cond_na);

bov_fout_voor = cond_voor * norm(resvec0) / sqrt(length(A));
bov_fout_na = cond_na * norm(resvec1) / sqrt(length(A));

fprintf("bovengrens voor fout zonder preconditionering: %d\n", bov_fout_voor);
fprintf("bovengrens voor fout met preconditionering: %d\n", bov_fout_na);

end