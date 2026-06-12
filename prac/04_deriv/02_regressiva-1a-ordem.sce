//==================================================================
// Função Regressiva de 1ª Ordem
// Objetivo: Aproximar a 1ª derivada usando a formula de diferenças finitas
//           regressiva de 1ª ordem
//==================================================================
// Entradas:
//  X   :   vetor com os valores dos nós
//  Y   :   vetor com os valores das imagens
//  k   :   índice do ponto onde será calculada a derivada
//  derivada_1a_exata   :   valor exato da 1ª derivada (para erro percentual)
//  derivada_2a_exata   :   valor exato da 2ª derivada (para erro de truncamento)
//==================================================================
// Saídas:
// apenas impressão de reusltados
//==================================================================

function Regressiva_1a_Ordem(X, Y, k, derivada_1a_exata, derivada_2a_exata)
    h = abs(X(k) - X(k - 1))
    derivada_numerica = (Y(k) - Y(k - 1)) / h
    
    printf("\n/////////////////////////////////////////////////////////\n")
    printf(" Cálculo da derivada de 1a ordem em x = %g pela fórmula Regressiva de 1a Ordem:\n", X(k))
    printf(" Aproximação: (f(xk) - f(xk - 1)) / h\n")
    printf(" Computando: (%f - %f) / %f\n", Y(k), Y(k - 1), h)
    printf(" Resultado: %f\n", derivada_numerica)
    Imprimir_Erro(derivada_1a_exata, derivada_numerica)
    Erro_Truncamento_P(h, derivada_2a_exata)
endfunction