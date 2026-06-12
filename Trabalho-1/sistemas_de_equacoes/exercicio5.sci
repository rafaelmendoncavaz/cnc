clear();
clc();

printf("\n");
printf("\t\t############################################################\n");
printf("\t\t#                                                          #\n");
printf("\t\t#                >>> INICIO DO PROGRAMA <<<                #\n");
printf("\t\t#                                                          #\n");
printf("\t\t############################################################\n\n\n");

printf("\n\n**************** Eliminação de Gauss ****************\n\n")

A = [2, -1, 0, 0, 0;
     -1, 2,-1, 0, 0;
     0, -1, 2, -1, 0;
     0, 0, -1, 2, -1;
     0, 0, 0, -1, 2];
B = [100, 0, 0, 0, 200];
T = A


A_global = A
B_global = B
T_global = T

printf("\n .....Entrada - Matriz A (original).....:\n")
disp(A)
printf("\n .....Entrada - Vetor B (original).....:\n")
disp(B)

n = length(B)
for k = (1:n-1)
    if A(k, k) == 0 then
        error("\n Erro: surgiu pivô nulo durante o escalonamento\n")
    end
	for i = (k+1:n)
		m = A(i, k)/A(k, k)
		A(i, k) = 0
		for j = (k+1:n)
			A(i, j) = A(i, j) - A(k, j) * m
		end
		B(i) = B(i) - B(k) * m
		// printf("\nMatriz A\n")
		// disp(A);
		// printf("\nMatriz B\n")
		// disp(B)
	end
end

printf("------Entrada - Matriz A (triangularizada)------:\n")
disp(A)
printf("\n .....Entrada - Vetor B (triangularizada).....:\n")
disp(B)

U = A
C = B
n = length(C)
X(n) = C(n)/U(n, n)
for k = (n-1:-1:1)
    soma = 0
    for j = (k+1:n)
        soma = soma + U(k, j)*X(j)
    end
    X(k) = (C(k) - soma)/U(k, k)
end

printf("\n .....Saida - Solucao X (do sistema AX=B).....:\n")
mprintf(" %.6f\n", [X])
printf("\n ------------Verificacao do resultado se AX = B------------\n")
for i = (1:n)
    s = 0
    for j = (1:n)
        s = s + T(i, j)*X(j)
        if (j < n)
            printf("(%.3d*%.3f) + ", T(i, j), X(j))
        end
        if (j == n)
            printf("(%.3d*%.3f) ", T(i, j), X(j))
            printf("= %.6f\n", s)
        end
    end
end
printf("\n\n**************** Fim da Eliminacao de Gauss ****************\n\n")


printf("\n================================================================================================================\n")


printf("\n\n**************** Fatoracao LU ****************\n\n");


A = A_global
B = B_global
T = T_global

printf("\n .....Entrada - Matriz A (original).....:\n");
disp(A);
printf("\n .....Entrada - Vetor B (original).....:\n");
disp(B);

n = length(B);
L = zeros(n, n);
U = zeros(n, n);

for j = 1:n
    U(j, j) = 1;
end

for j = 1:n
    for i = j:n
        SomaLU = 0;
        for k = 1:j-1
            SomaLU = SomaLU + L(i, k)*U(k, j);
        end
        L(i, j) = A(i, j) - SomaLU;
    end
        if L(j, j) == 0 then
            error("\n Erro: surgiu pivô nulo durante a fatoração LU\n");
        end
    for i = j+1:n
        SomaLU = 0;
        for k = 1:j-1
            SomaLU = SomaLU + L(j, k)*U(k, i);
        end
        U(j, i) = (A(j, i) - SomaLU)/L(j, j);
    end
end

printf("\n .....Matriz L (triangular inferior).....:\n");
disp(L);
printf("\n .....Matriz U (triangular superior).....:\n");
disp(U);

Y = zeros(n, 1);
if L(1, 1) == 0 then
    error("\n Erro: surgiu pivô nulo durante a substituição progressiva\n");
end
Y(1) = B(1)/L(1, 1);
for i = 2:n
    SomaLY = 0;
    for j = 1:i-1
        SomaLY = SomaLY + L(i, j)*Y(j);
    end
    if L(i, i) == 0 then
        error("\n Erro: surgiu pivô nulo durante a substituição progressiva\n");
    end
    Y(i) = (B(i) - SomaLY)/L(i, i);
end

printf("\n .....Vetor Y (solucao de LY=B).....:\n");
disp(Y);

X = zeros(n, 1);

X(n) = Y(n);

for i = (n-1:-1:1)
    SomaUX = 0;
    for j = i+1:n
        SomaUX = SomaUX + U(i, j)*X(j);
    end
    if U(i, i) == 0 then
        error("\n Erro: surgiu pivô nulo durante a substituição retroativa\n");
    end
    X(i) = Y(i) - SomaUX;
end

printf("\n .....Vetor X (solucao de UX=Y).....:\n");
disp(X);
printf("\n ------------Verificacao do resultado se AX = B------------\n\n");
//Verificacao do resultado se AX = B
for i = (1:n)
    s = 0;
    for j = (1:n)
        s = s + T(i, j)*X(j);
        if (j < n) then
            printf("(%.3f*%.3f) + ", T(i, j), X(j));
        end
        if (j == n) then
            printf("(%.3f*%.3f) = ", T(i, j), X(j));
            printf("%.6f\n", s);
        end
    end
end

printf("\n\n**************** Fim da Decomposicao LU-Crout ****************\n\n");


printf("\n===============================================================================================================\n")


printf("\n\n**************** MÉTODO: TDMA****************\n\n")


printf("*** MÉTODO DIRETO: THOMAS (TDMA) - SISTEMAS TRIDIAGONAIS ***\n");

a = [0; -1; -1; -1; -1]; //diagonal superior
b = [2; 2; 2; 2; 2];  //diagonal principal
c = [-1; -1; -1; -1; 0];  //diagonal inferior
d = [100; 0; 0; 0; 200];  //termos independente

ta = a;
tb = b;
tc = c;
td = d;


printf("\n Vetor a:\n");
for i = 1 : length(a)
    mprintf("%10.6f\n", a(i));
end

printf("\n Vetor b:\n");
for i = 1 : length(b)
    mprintf("%10.6f\n", b(i));
end

printf("\n Vetor c:\n");
for i = 1 : length(c)
    mprintf("%10.6f\n", c(i));
end

printf("\n Vetor d:\n");
for i = 1 : length(d)
    mprintf("%10.6f\n", d(i));
end

printf("\n**********************TRIANGULARIZACAO***************************\n");

n = length(b)
if b(1) == 0 then
    error("Pivô nulo encontrado na primeira linha. Método falha.");
end

c(1) = c(1) / b(1);
d(1) = d(1) / b(1);

for i = 2:n-1
    temp = b(i) - a(i) * c(i-1);
    if temp == 0 then
        error("Pivô nulo encontrado durante a triangulariacao");
    end
    c(i) = c(i) / temp;
    d(i) = (d(i) - a(i) * d(i-1)) / temp;
end

temp = b(n) - a(n) * c(n-1);

if temp == 0 then
    error("Pivô nulo encontrado na última linha. Método falha.");
end
d(n) = (d(n) - a(n) * d(n-1)) / temp;

printf("\n saida - vetor c modificado:\n");
for i = 1 : n
    mprintf("%10.6f\n", c(i));
end

printf("\n saida - vetor d modificado:\n");
for i = 1 : n
    mprintf("%10.6f\n", d(i));
end


printf("\n**********************RETROSUBSTITUICAO***************************\n");
//algoritmo de retrosubstituição
X = zeros(n,1);
X(n) = d(n);
for i = (n-1:-1:1)
    X(i) = d(i) - c(i) * X(i+1);
end

printf("\n Solução X do sistema:\n");
mprintf("  %.6f\n", X);

printf("\n ****************Verificação da solução se TX = d:***********\n\n");

for i = 1:n
    s = 0;
    if i > 1 then
        s = s + ta(i) * X(i-1);
        printf("(%.3f * %.3f) + ", ta(i), X(i-1));
    end

    s = s + tb(i) * X(i);
    if i < n then
        printf("(%.3f * %.3f) + ", tb(i), X(i));
        s = s + tc(i) * X(i+1);
        printf("(%.3f * %.3f) = ", tc(i), X(i+1));
    else
        printf("(%.3f * %.3f) = ", tb(i), X(i));
    end
    printf(" %.3f\n", s);
end



printf("\n\n**************** ENCERRAMENTO DO TDMA ****************\n\n");


printf("\n===============================================================================================================\n")


printf("\n\n**************** MÉTODO: GAUSS-JACOBI GULOSO****************\n\n")

A = A_global
B = B_global

printf("\n Matriz A(original):\n");
disp(A);
printf("\n Vetor B(original):\n");
disp(B);

n = size(A,1)
Nmax = 200
epsilon = 1.0e-6
X0 = [0; 0; 0; 0; 0];
X = X0
T = T_global;

function [A_greedy, B_greedy, sucesso, ordem] = reordenar_greedy(A, B)
    n = size(A,1)
    usados = zeros(n,1)
    ordem = zeros(n,1)
    sucesso = %T
    
    for j = 1:n
        maior = -%inf
        linha_melhor = -1
        for i = 1:n
            if usados(i) == 0 then
                if abs(A(i,j)) > maior then
                    maior = abs(A(i,j))
                    linha_melhor = i
                end
            end
        end
        if linha_melhor == -1 then
            sucesso = %F
            A_greedy = A
            B_greedy = B
            return
        end
        ordem(j) = linha_melhor
        usados(linha_melhor) = 1
    end
    
    A_greedy = A(ordem, :)
    B_greedy = B(ordem)
endfunction

printf("\n****** Reordenação Gulosa ******\n\n")
[A, B, sucesso, ordem_linhas] = reordenar_greedy(A,B)

if sucesso then
    printf("\n Reordenação Gulosa aplicada com sucesso.\n")
    printf(" Ordem das linhas escolhida:\n")
    disp(ordem_linhas')
    
    printf("\n Matriz A após reordenação:\n")
    disp(A)
    printf("\n Vetor B após ordenação:\n")
    disp(B)
else
    error(" Não foi possível aplicar a reordenação gulosa.")
end


for i = 1:n
    if T(i,i) == 0 then
        error("Pivô nulo encontrado na diagonal principal. Método falha.\n\n");
    end
end

convergiu = %f;
for k = 1:Nmax
    for i = 1:n
        S = 0;
        for j = 1:n
            if i ~= j then
                S = S + A(i,j) * X0(j);
            end
        end
        X(i) = (B(i) - S) / A(i,i);
    end
    erro = max(abs(X-X0));
    if erro < epsilon then
        convergiu = %t;
        break;
    end
    X0 = X;
end

printf("\n Número de iterações: %d\n", k);
printf( "\n Erro final: %.6e\n", erro);
if convergiu then
    printf("\n O método convergiu para a solução aproximada.\n");
else
    printf("\n O método não convergiu dentro do número máximo de iterações.\n");
end

printf("\n Vetor solução aproximada:\n");
disp(X);

printf("\n Verificação dos resultados (A*X = B):\n");
for i = 1:n
    s = 0
    for j = 1:n
        s = s + T(i,j) * X(j)
        if j < n then
            printf(" (%.3f*%.3f) +", T(i,j), X(j))
        end
        if j == n then
            printf(" (%.3f*%.3f) = ", T(i,j), X(j))
            printf("%.5f\n", s)
        end
    end
end

printf("\n\n**************** ENCERRAMENTO DO GAUSS-JACOBI GULOSO ****************\n\n")


printf("\n===============================================================================================================\n")


printf("\n\n**************** MÉTODO ITERATIVO: GAUSS-SEIDEL GULOSO ****************\n\n")

A = A_global
B = B_global

printf("\n Matriz A(original):\n");
disp(A);
printf("\n Vetor B(original):\n");
disp(B);

n = length(B);
epsilon = 1.0e-6
X0 = [0; 0; 0; 0; 0];
X = X0
T = T_global

//Verificação de pivos na diagonal principal
for i = 1:n
    if T(i,i) == 0 then
        error("Pivô nulo encontrado na diagonal principal. Método falha.\n\n");
    end
end

printf("\n*********Processo Iterativo ************\n");
convergiu = %f;
funcprot(0)

function [A_greedy, B_greedy, sucesso, ordem] = reordenar_greedy(A, B)
    n = size(A,1);
    usados = zeros(n,1);
    ordem = zeros(n,1);
    sucesso = %T;
    
    for j = 1:n
        maior = -%inf;
        linha_melhor = -1;
        for i = 1:n
            if usados(i) == 0 then
                if abs(A(i,j)) > maior then
                    maior = abs(A(i,j));
                    linha_melhor = i;
                end
            end
        end
        if linha_melhor == -1 then
            sucesso = %F;
            A_greedy = A;
            B_greedy = B;
            return;
        end
        ordem(j) = linha_melhor;
        usados(linha_melhor) = 1;
    end
    
    A_greedy = A(ordem, :);
    B_greedy = B(ordem);
endfunction;

[A, B, sucesso, ordem_linhas] = reordenar_greedy(A,B);

if sucesso then
    printf("\n Reordenação Gulosa aplicada com sucesso.\n");
    printf(" Ordem das linhas escolhida:\n");
    disp(ordem_linhas');
    
    printf("\n Matriz A após reordenação:\n");
    disp(A);
    printf("\n Vetor B após ordenação:\n");
    disp(B);
else
    error(" Não foi possível aplicar a reordenação gulosa.");
end

for k = 1:Nmax
    X = X0;
    for i = 1:n
        S1 = 0;
        for j = 1:i-1
            S1 = S1 + A(i,j) * X(j);
        end
        S2 = 0;
        for j = i+1:n
            S2 = S2 + A(i,j) * X0(j);
        end
        X(i) = (B(i) - S1 - S2) / A(i,i);
    end
    erro = max(abs(X - X0));
    if erro < epsilon then
        convergiu = %t;
        break;
    end
    X0 = X;
end

printf("\n Número de iterações: %d\n", k);
printf( "\n Erro final: %.6e\n", erro);
if convergiu then
    printf("\n O método convergiu para a solução aproximada.\n");
else
    printf("\n O método não convergiu dentro do número máximo de iterações.\n");
end

printf("\n Vetor solução aproximada:\n");
disp(X);

printf("\n Verificação dos resultados (A*X = B):\n");
for i = 1:n
    s = 0
    for j = 1:n
        s = s + T(i,j) * X(j)
        if j < n then
            printf(" (%.3f*%.3f) +", T(i,j), X(j))
        end
        if j == n then
            printf(" (%.3f*%.3f) = ", T(i,j), X(j))
            printf("%.5f\n", s)
        end
    end
end

printf("\n\n**************** ENCERRAMENTO DO GAUSS-SEIDEL GULOSO ****************\n\n")
