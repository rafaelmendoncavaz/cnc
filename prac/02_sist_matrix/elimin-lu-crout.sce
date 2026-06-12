clear();
clc();

printf("\n***** MÉTODO DE DECOMPOSIÇÃO LU - Crout *****\n");
printf(" Resolução direta de sistema de equações lineares \n");

// Exemplo 3.1
printf("\n ***** Dados de Entrada - Matriz A e Vetor B *****: \n");
// Dados de entrada - Matriz dos coeficientes e vetor dos termos independentes
A = [3, 2, 4; 1, 1, 2; 4, 3, -2];
B = [1; 2; 3];
T = A;

printf("\n .....Entrada - Matriz A (original).....:\n")
disp(A)
printf("\n .....Entrada - Matriz B (original).....:\n")
disp(B)

// Fatoração LU por Crout
n = length(B)
L = zeros(n, n);
U = zeros(n, n);

// A diagonal de U é unitária por Crout
for j = 1:n
    U(j, j) = 1;
end

for j = 1:n
    // Cálculo da coluna j de L
    for i = j:n
        SomaLU = 0;
        for k = 1:j-1
            SomaLU = SomaLU + L(i, k) * U(k, j);
        end
        L(i, j) = A(i, j) - SomaLU;
    end
    // Verificação de pivô nulo
    if L(j, j) == 0 then
        error("Erro: pivô nulo durante a fatoração LU-Crout.");
    end
    // Cálculo da linha j de U
    for i = j+1:n
        SomaLU = 0;
        for k = 1:j-1
            SomaLU = SomaLU + L(j, k) * U(k, i);
        end
        U(j, i) = (A(j, i) - SomaLU) / L(j, j);
    end
end

printf("\n Saída - Fator L:\n");
disp(L);
printf("\n Saída - Fator U:\n");
disp(U);

// -----------------

printf("\n********** Substituição Progressiva **********\n");
// Resolução de LY = B
Y = zeros(n, 1);
if L(1, 1) == 0 then
    error("ERRO: pivô nulo durante a substituição progressiva");
end
Y(1) = B(1) / L(1, 1);
for i = 2:n
    SomaLY = 0;
    for j = 1:i-1
        SomaLY = SomaLY + L(i, j) * Y(j);
    end
    
    if L(i, i) == 0 then
        error("ERRO: pivô nulo durante a substituição progressiva");
    end
    Y(i) = (B(i) - SomaLY) / L(i, i);
end

printf("\n Solução Y (LY = B) do sistema:\n");
disp(Y);

// ----------------
printf("\n********** Substituição retroativa **********\n");
// Resolução de UX = Y
X = zeros(n, 1);

// Como U tem diagonal unitária por Crout, é desnecessária a divisão por U(i, i)
X(n) = Y(n);
for i = (n-1:-1:1)
    SomaUX = 0;
    for j = (i+1:n)
        SomaUX = SomaUX + U(i, j) * X(j);
    end
    X(i) = Y(i) - SomaUX;
end

printf("\n Solução X (UX = Y) do sistema:\n");
mprintf("  %.6f\n", X);

// ----------------
printf("\n***** Verificação da solução, se AX = B *****\n\n");
// Verificação dos resultados mostrando que AX = B
for i = 1:n
    s = 0;
    for j = 1:n
        s = s + T(i, j) * X(j);
        if (j < n) then
            printf("(%.3f * %.3f) + ", T(i, j), X(j));
        end
        if (j == n) then
            printf("(%.3f * %.3f) = ", T(i, j), X(j));
            printf("%.3f\n", s);
        end
    end
end
printf("\n********** Fim da decomposição LU-Crout**********\n");
