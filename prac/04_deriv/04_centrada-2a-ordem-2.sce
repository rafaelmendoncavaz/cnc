//==================================================================
// Função Centrada de 2ª Ordem 2
// Objetivo: Aproximar a 2ª derivada usando a formula de centrada de 2ª ordem
//==================================================================
// Entradas:
//  X   :   vetor com os valores dos nós
//  Y   :   vetor com os valores das imagens
//  k   :   índice do ponto onde será calculada a derivada
//  derivada_2a_exata   :   valor exato da 2ª derivada (para erro percentual)
//  derivada_4a_exata   :   valor exato da 4ª derivada (para erro de truncamento)
//==================================================================
// Saídas:
// apenas impressão de reusltados
//==================================================================

function Centrada_2a_Ordem_2a(X, Y, k, derivada_2a_exata, derivada_4a_exata)
    h1 = abs(X(k + 1) - X(k))
    h2 = abs(X(k) - X(k - 1))
    h_prod = h1 * h2
    derivada_numerica = (Y(k + 1) - 2 * Y(k) + Y(k - 1)) / h_prod

    printf("\n/////////////////////////////////////////////////////////\n")
    printf(" Cálculo da derivada de 2a ordem em x = %g pela fórmula Centrada de 2a Ordem:\n", X(k))
    printf(" Aproximação: (f(xk + 1) - 2 * f(xk) + f(xk - 1)) / (h1 * h2)\n")
    printf(" Computando: (%f - 2 * %f + %f) / %f\n", Y(k + 1), Y(k), Y(k - 1), h_prod)
    printf(" Resultado: %f\n", derivada_numerica)
    Imprimir_Erro(derivada_2a_exata, derivada_numerica)
    Erro_Truncamento_C22(h_prod, derivada_4a_exata)
endfunction