clear();
clc();

printf("\n***** Método Iterativo de Gauss-Jacobi *****\n");
printf("Resolução iterativa de sistemas lineares\n");

// EXEMPLO 3.10
// Dados de entrada: Matriz dos coeficientes e vetor dos termos independentes
A = [
4.0, 2.0, -0.3, 0.8;
0.6, 3.2, -1.8, 0.4;
0.1, 0.2, 1.0, 0.3;
0.3, -0.8, -0.3, -0.9
];

B = [4.4; 10.0; 4.0; 7.5];

/*
A = [
0.1, 0.2, 1.0, 0.3;
0.3, -0.8, -0.3, -0.9;
4.0, 2.0, -0.3, 0.8;
0.6, 3.2, -1.8, 0.4
];
B = [4.0; 7.5; 4.4; 10.0];
*/

printf("\n***** Dados de Entrada - Matriz A e Vetor B *****\n");
printf("\nMatriz A original\n");
disp(A);
printf("\nVetor B original\n");
disp(B);

n = size(A, 1); // dimensção do sistema quadrado
Nmax = 100; // número máximo de iterações
epsilon = 1.0e-6; // tolerância
X0 = [0; 0; 0; 0]; // aproximação inicial
X = X0; // vetor solução iterativa
T = A; // cópia para verificação final

for i = 1:n
    if A(i, i) == 0 then
        error("ERRO: elemento nulo na diagonal principal");
    end
end

printf("********** Processo Iterativo **********\n");
// Laço principal do mét. iterativo de Gauss-Jacobi
convergiu = %f;
for k = 1:Nmax
    for i = 1:n
        S = 0;
        for j = 1:n
            if i ~= j then
                S = S + A(i, j) * X0(j);
            end
        end
        X(i) = (B(i) - S) / A(i, i);
    end
    erro = max(abs(X - X0));
    if erro < epsilon then
        convergiu = %t;
        break;
    end
    X0 = X;
end

printf("\n Número de iterações: ");
disp(k);
printf("\n Erro final: %.6e\n", erro);

if convergiu then
    printf("\n O método convergiu dentro da tolerância estabelecida\n");
else
    printf("\n ATENÇÃO: o método atingiu o número máximo de iterações sem convergir\n");
end

printf("\n Vetor solução do sistema:\n");
mprintf("  %.6f\n", X);

printf("\n***** Verificação da solução, se AX = B *****\n\n");
// Verificação dos resultados mostrando que AX = B
for i = 1:n
    s = 0;
    for j = 1:n
        s = s + T(i, j) * X(j);
        if j < n then
            printf("(%.3f * %.3f) + ", T(i, j), X(j));
        end
        if j == n then
            printf("(%.3f * %.3f) = ", T(i, j), X(j));
            printf("%.3f\n", s);
        end
    end
end

printf("\n********** FIM Do Met. Gauss-Jacobi **********\n");
