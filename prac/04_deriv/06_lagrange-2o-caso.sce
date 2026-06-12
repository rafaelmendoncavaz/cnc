//==================================================================
// Função Lagrange 2º Caso
// Objetivo: Aproximar a 1ª derivada usando o polinômio de Lagrange (2º Caso)
// Fórmula centrada simétrica com três pontos
//==================================================================
// Entradas:
//  X   :   vetor com os valores dos nós
//  Y   :   vetor com os valores das imagens
//  k   :   índice do ponto onde será calculada a derivada
//  derivada_1a_exata   :   valor exato da 2ª derivada (para erro percentual)
//==================================================================
// Saídas:
// apenas impressão de reusltados
//==================================================================

function Lagrange_2o_Caso(X, Y, k, derivada_1a_exata)
    h1 = abs(X(k + 1) - X(k))
    h2 = abs(X(k) - X(k - 1))
    h = h1 + h2
    derivada_numerica = (Y(k + 1) - Y(k - 1)) / h

    printf("\n/////////////////////////////////////////////////////////\n")
    printf(" Cálculo da derivada de 1a ordem em x = %g pelo Método de Lagrange - 2º Caso (centrado):\n", X(k))
    printf(" Aproximação: (f(xk + 1) - f(xk - 1)) / h\n")
    printf(" Computando: (%f - %f) / %f\n", Y(k + 1), Y(k - 1), h)
    printf(" Resultado: %f\n", derivada_numerica)
    Imprimir_Erro(derivada_1a_exata, derivada_numerica)
endfunction