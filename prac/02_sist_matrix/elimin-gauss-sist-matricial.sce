clear();
clc();

printf("\n********** Triangularizacao **********\n")
printf(" Geracao de matriz triangular superior\n\n")

// ---------- EXEMPLO 3.1 ----------
// Dados de entrada - Matriz dos coef. e vetor solucao...
A = [3, 2, 4; 1, 1, 2; 4, 3, -2]
// B = [1; 5/3; 0]
B = [1; 2; 3]
T = A

printf("\n .....Entrada - Matriz A (original).....:\n")
disp(A)
printf("\n .....Entrada - Matriz B (original).....:\n")
disp(B)

n = length(B)

// printf("\n Dimensao da matriz:")
// disp(n)	// atribuicao para verificacao dos resultados

printf("\n********** Triangularizacao **********:\n")

// Algoritmo de triangularizacao

n = length(B)
for k = (1:n-1)
    // Teste do pivô nulo
    if A(k, k) == 0 then
        error("ERRO: surgiu pivo nulo durante o escalonamento");
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

printf("\n .....Entrada - Matriz A (original).....:\n")
disp(A)
printf("\n .....Entrada - Matriz B (original).....:\n")
disp(B)

printf("\n********** Retrosubstituicao **********:\n")   
//Algoritmo de retrosubstituicao

U = A
C = B
n = length(C)
X(n) = C(n)/U(n, n)
for k = (n-1:-1:1)
    soma = 0
    for j = (k+1:n)
        soma = soma + U(k, j)*X(j)
    end
    //printf("\nSoma: %2.2f\n", soma)
    //printf("\n Multiplicacao: %2.2f\n", U(k, k))
    X(k) = (C(k) - soma)/U(k, k)
end

//Dados de saida - solucao X, do sistema AX=B
printf("\n .....Saida - Solucao X (do sistema AX=B).....:\n")
mprintf(" %.6f\n", [X])
printf("\n ------------Verificacao do resultado se AX = B------------\n")
for i = (1:n)
    s = 0
    for j = (1:n)
        s = s + T(i, j)*X(j)
        if (j < n)
            printf("(%d*%.6f) + ", T(i, j), X(j))
        end
        if (j == n)
            printf("(%d*%.6f) ", T(i, j), X(j))
            printf("= %.6f\n", s)
        end
    end
end
printf("****************Fim da Eliminacao de Gauss****************\n")
