function [x0, x1, resvec0, resvec1] = laad_gmres_gegevens(pad)
load(pad, "A")

b = ones(length(A), 1);

[x0, ~, ~, ~, resvec0] = gmres(A, b);
[L, U] = incompl_lu_decomp(A);
[y_1,  ~, ~, ~, resvec1] = gmres(@(x) A * (solve_Ub(U, solve_Lb(L, x))), b);
x1 = solve_Ub(U, solve_Lb(L, y_1));
end