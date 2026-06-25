//==================================================================
// Função: Simpson_1_3_Dados
// Objetivo: Calcular a integral aproximada usando o Método de Simpson 1/3
//			 generalizado com dados tabulados
//==================================================================
// Entradas:
//	X 	: vetor com os valores dos nós (x_i)
//	Y	: vetor com os valores das imagens (f(x_i))
// integral_exata	: valor exato da integral (para cálculo do erro percentual)
//==================================================================
// Saídas: apenas impressão dos resultados
//==================================================================
function Simpson_1_3_Dados(X, Y, integral_exata)
	num_pontos = length(X)
	h = X(2) - X(1)

	printf("\n/////////////////////////////////////////////////////////\n")
	printf(" Integração numérica pelo método de Simpson 1/3 Generalizado (dados tabulados):\n")
	printf(" Intervalo de %g a %g com %d pontos igualmente espaçados.\n", X(1), X(num_pontos), num_pontos)
	printf(" Fórmula: I ≃ (h / 3) * [f(x0) + 4 * Σ(ímpares) + 2 * Σ(pares) + f(xn)]\n")
	//==================================================================
	somatorio_impares = sum(Y(2:2:num_pontos - 1))
	somatorio_pares = sum(Y(3:2:num_pontos - 1))
	integral_numerica = (h / 3) * (Y(1) + 4 * somatorio_impares + 2 * somatorio_pares + Y(num_pontos))
	//==================================================================
	printf(" h = %f\n", h)
	printf(" Integral aproximada: %f\n", integral_numerica)
	erro_percentual = abs((integral_exata - integral_numerica) / integral_exata) * 100
	printf(" Erro relativo percentual: %.6f %%\n", erro_percentual)
endfunction
