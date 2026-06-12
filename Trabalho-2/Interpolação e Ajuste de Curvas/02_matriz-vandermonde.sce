// Função: vander_matrix
// Objetivo: Gerar a matriz de Vandermonde associada a ovetor de nós X
//--------------------------------------------------------
// Entradas:
// X : Vetor com os valores dos nós (pontos x_i)
// Saídas
// V: Matriz de Vandermonde correspondente, de ordem N x N
//--------------------------------------------------------
// Observações:
// - A matriz de Vandermonde tem a forma:
//      V(i, j) = X(i) ^(j-1)
// - Sendo usada para interpolação polinomial via sistema linear
//--------------------------------------------------------
function V = vander_matrix(X)
    n = length(X); // Numero de pontos
    V = zeros(n, n); // Inicializa matriz N x N

    for i = 1:n
        for j = 1:n
            V(i, j) = X(i)^(j - 1);
        end
    end
endfunction
//--------------------------------------------------------