//==================================================================
// Função: Simpson_1_3_Dados
// Objetivo: Calcular a integral aproximada usando o Método de Simpson 3/8
//			 generalizado com dados tabulados
//==================================================================
// Entradas:
//	X 	: vetor com os valores dos nós (x_i)
//	Y	: vetor com os valores das imagens (f(x_i))
// integral_exata	: valor exato da integral (para cálculo do erro percentual)
//==================================================================
// Saídas: apenas impressão dos resultados
//==================================================================
function Simpson_3_8_Dados(X, Y, integral_exata)
	num_pontos = length(X)
	h = X(2) - X(1)

	printf("\n/////////////////////////////////////////////////////////\n")
	printf(" Integração numérica pelo método de Simpson 3/8 Generalizado (dados tabulados):\n")
	printf(" Intervalo de %g a %g com %d pontos igualmente espaçados.\n", X(1), X(num_pontos), num_pontos)
	printf(" Fórmula: I ≃ (3h / 8) * [f(x0) + 3 * Σ(grupo_1) + 2 * Σ(grupo_2) + f(xn)]\n")
	//==================================================================
	somatorio_1 = 0
	somatorio_2 = 0

	// Grupo 1
	for i = 2:3:num_pontos - 1
		somatorio_1 = somatorio_1 + Y(i) + Y(i + 1)
	end

	// Grupo 2
	for i = 4:3:num_pontos - 1
		somatorio_2 = somatorio_2 + Y(i)
	end

	integral_numerica = (3 * h / 8) * (Y(1) + 3 * somatorio_1 + 2 * somatorio_2 + Y(num_pontos))
	//==================================================================
	printf(" h = %f\n", h)
	printf(" Integral aproximada: %f\n", integral_numerica)
	erro_percentual = abs((integral_exata - integral_numerica) / integral_exata) * 100
	printf(" Erro relativo percentual: %.6f %%\n", erro_percentual)
endfunction
