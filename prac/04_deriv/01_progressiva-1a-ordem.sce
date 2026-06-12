//==================================================================
// Função Progressiva de 1ª Ordem
// Objetivo: Aproximar a 1ª derivada usando a formula de diferenças finitas
//           progressiva de 1ª ordem
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

function Progressiva_1a_Ordem(X, Y, k, derivada_1a_exata, derivada_2a_exata)
    h = abs(X(k + 1) - X(k))
    derivada_numerica = (Y(k + 1) - Y(k)) / h
    
    printf("\n/////////////////////////////////////////////////////////\n")
    printf(" Cálculo da derivada de 1a ordem em x = %g pela fórmula Progressiva de 1a Ordem:\n", X(k))
    printf(" Aproximação: (f(xk + 1) - f(xk)) / h\n")
    printf(" Computando: (%f - %f) / %f\n", Y(k + 1), Y(k), h)
    printf(" Resultado: %f\n", derivada_numerica)
    Imprimir_Erro(derivada_1a_exata, derivada_numerica)
    Erro_Truncamento_P(h, derivada_2a_exata)
endfunction