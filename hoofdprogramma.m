%% Opdracht 3

n = 8;

% Genereer een willekeurige onderdriehoeksmatrix 
% met diagonaalelementen gelijk aan 1.

L = rand(n);
for i = 1:n
    L(i, i) = 1;
    for j = i+1:n
        L(i, j) = 0;
    end
end

% Genereer een willekeurige bovendriehoeksmatrix.
U = rand(n);
for j = 1:n
    for i = j+1:n
        U(i, j) = 0;
    end
end

A = L * U;

[test_L, test_U] = lu_decomp(A);

tolerantie = 1e-12;

% equivalent: assert(all(ismembertol(L, test_L, tolerantie) == 1, [1 2])
assert(isequal(ones(n), ismembertol(L, test_L, tolerantie)));
assert(isequal(ones(n), ismembertol(U, test_U, tolerantie)));

fprintf('Opdracht 3: test OK\n')

%% Opdracht 5

clear;
test_U = [1 2 3; 0 4 5; 0 0 6];
test_b = [1 4 9];
verwachte_y = [-1.75 -0.875 1.5];

assert(all(ismembertol(solve_Ub(test_U, test_b), verwachte_y) == 1));

test_L = [1 0 0; 1 2 0; 3 5 8];
test_b = [3 1 4];
verwachte_y = [3 -1 0];

assert(all(ismembertol(solve_Lb(test_L, test_b), verwachte_y) == 1));

fprintf('Opdracht 5: test OK\n')

%% Opdracht 6
clear;
n = 5;

[A_1, A_2] = genereer_A_matrices(5);

[L_1, U_1] = lu_decomp(A_1);
[L_2, U_2] = lu_decomp(A_2);

fprintf('L_1 bevat %d nullen\n', sum(L_1(:) == 0));
fprintf('U_1 bevat %d nullen\n', sum(U_1(:) == 0));
fprintf('L_2 bevat %d nullen\n', sum(L_2(:) == 0));
fprintf('U_2 bevat %d nullen\n', sum(U_2(:) == 0));

%% Opdracht 9

% genereren van de LU-decomposities

%{
all_L1 = cell(13, 1);
all_U1 = cell(13, 1);
all_L2 = cell(13, 1);
all_U2 = cell(13, 1);

for i = 0:12
   n = 1000 + i * 500;
   [A_1, A_2] = genereer_A_matrices(n);

   fprintf('A-matrices van grootte %d gegenereerd\n', n);

    [L_1, U_1] = lu(A_1);
    [L_2, U_2] = lu(A_2);

    fprintf('Matrices van grootte %d gegenereerd\n', n);

    all_L1{i + 1} = L_1;
    all_U1{i + 1} = U_1;

    all_L2{i + 1} = L_2;
    all_U2{i + 1} = U_2;
end
save("decomposities.mat", "all_L1", "all_U1", "all_L2", "all_U2", "-v7.3")

%}

load("decomposities.mat")

runs = 150;
% oplossen van stelsels mbt A1

tijden_A1 = zeros(1, 13);

for i = 1:13
    L = all_L1{i};
    U = all_U1{i};

    b = ones(length(U), 1);

    tijden = zeros(runs, 1);

    for j = 1:runs
        tic
        y = solve_Lb(L, b);
        opl = solve_Ub(U, y);
        tijden(j) = toc;
    end

    tijden_A1(i) = mean(tijden(2:end));

    fprintf("run met n = %d duurde %d seconden\n", length(U), tijden_A1(i));
end

figure(1)
subplot(2, 1, 1)

plot(1000:500:7000, tijden_A1,'b')
title("Niet-spaarse variant") 
ylabel("tijdsduur (s)")
xlabel("grootte van matrix")

hold on

% oplossen van stelsels mbt A2

tijden_A2 = zeros(1, 13);
for i = 1:13
    L = all_L2{i};
    U = all_U2{i};

    b = ones(length(U), 1);

    tijden = zeros(runs, 1);

    for j = 1:runs
        tic
        y = solve_Lb_special(L, b);
        opl = solve_Ub_special(U, y);
        tijden(j) = toc;
    end
    
    tijden_A2(i) = mean(tijden(2:end));

    fprintf("run met n = %d duurde %d seconden\n", length(U), tijden_A2(i));
end

subplot(2, 1, 2)

plot(1000:500:7000, tijden_A2,'r')
title("Spaarse variant")
ylabel("tijdsduur (s)")
xlabel("grootte van matrix")

%% Opdracht 13
fprintf("Resultaten voor matrix B1:\n");
[
    x0_1, x1_1, ...
    resvec0_1, resvec1_1, ...
    cond_voor_1, cond_na_1, ...
] = laad_gmres_gegevens("matrix_B1.mat");
fprintf("Resultaten voor matrix B2:\n");
[
    x0_2, x1_2, ...
    resvec0_2, resvec1_2, ...
    cond_voor_2, cond_na_2, ...
] = laad_gmres_gegevens("matrix_B2.mat");


figure(1);
subplot(2, 1, 1);

semilogy(resvec0_1, 'r');
hold on;
semilogy(resvec1_1, 'b');
title("B_1");
xlabel("iteratiestappen");
ylabel("residu")
legend( ...
    sprintf("zonder preconditionering (κ = %d)", cond_voor_1), ...
    sprintf("met preconditionering (κ = %d)", cond_na_1) ...
);


subplot(2, 1, 2);

semilogy(resvec0_2, 'r');
hold on;
semilogy(resvec1_2, 'b');
title("B_2")
xlabel("iteratiestappen");
ylabel("residu")
legend( ...
    sprintf("zonder preconditionering (κ = %d)", cond_voor_2), ...
    sprintf("met preconditionering (κ = %d)", cond_na_2) ...
);

%% Opdracht 16

% Algemene LU-decompositie

tijden_LU = zeros(1, 13);
for i = 1:13
    L = all_L1{i};
    U = all_U1{i};

    b = ones(length(U), 1);

    tijden = zeros(runs, 1);

    for j = 1:runs
        tic
        y = solve_Lb(L, b);
        opl = solve_Ub(U, y);
        tijden(j) = toc;
    end
    
    tijden_LU(i) = mean(tijden(2:end));

    fprintf("run met n = %d duurde %d seconden\n", length(U), tijden_LU(i));
end


runs = 150;
tijden_PQ = zeros(1, 13);
for i = 1:13
    L = all_L2{i};
    U = all_U2{i};

    P = flip(speye(length(U)));
    Q = P; % zie bewijs bij oefening 15

    b = ones(length(U), 1);

    Pb = P * b; % plumbum

    tijden = zeros(runs, 1);

    for j = 1:runs
        tic
        y = solve_Lb_special(L, Pb);
        z = solve_Ub_special(U, y);
        opl = Q * z;
        tijden(j) = toc;
    end
    
    tijden_PQ(i) = mean(tijden(2:end));

    fprintf("run met n = %d duurde %d seconden\n", length(U), tijden_PQ(i));
end

figure(1)
subplot(2, 1, 1)

plot((0:12)*500+1000, tijden_LU,'b')
title("LU-factorisatie") 
ylabel("tijdsduur (s)")
xlabel("grootte van matrix")

hold on

subplot(2, 1, 2)

plot((0:12)*500+1000, tijden_PQ,'r')
title("PQ-factorisatie")
ylabel("tijdsduur (s)")
xlabel("grootte van matrix")
