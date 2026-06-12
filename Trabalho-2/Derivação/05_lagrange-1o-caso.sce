//==================================================================
// Função Lagrange 1º Caso
// Objetivo: Aproximar a 1ª derivada usando o polinômio de Lagrange (1º Caso)
// Fórmula assimétrica progressiva de ordem 2 (3 pontos à frente)
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

function Lagrange_1o_Caso(X, Y, k, derivada_1a_exata)
    h1 = abs(X(k) - X(k + 1))
    h2 = abs(X(k + 1) - X(k + 2))
    h = h1 + h2
    derivada_numerica = (-3 * Y(k) + 4 * Y(k + 1) - Y(k + 2)) / h

    printf("\n/////////////////////////////////////////////////////////\n")
    printf(" Cálculo da derivada de 1a ordem em x = %g pelo Método de Lagrange - 1º Caso (progressivo):\n", X(k))
    printf(" Aproximação: (-3 * f(xk) + 4 * f(xk + 1) - f(xk + 2)) / h\n")
    printf(" Computando: (-3 * %f + 4 * %f - %f) / %f\n", Y(k), Y(k + 1), Y(k + 2), h)
    printf(" Resultado: %f\n", derivada_numerica)
    Imprimir_Erro(derivada_1a_exata, derivada_numerica)
endfunction