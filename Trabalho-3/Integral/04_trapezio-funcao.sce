//==================================================================
// Função: Trapezio_Funcao
// Objetivo: Calcular a integral aproximada usando o Método do Trapézio
//			 com avaliação direta da função (não tabulada)
//==================================================================
// Entradas:
// 	f 	: função a ser integrada (definida via deff)
//	x0 	: limite inferior da integral
//	xn	: limite superior da integral
// 	n 	: número de subintervalos (quanto maior, mais precisa a aproximação)
// integral_exata	: valor exato da integral (para cálculo do erro percentual)
//==================================================================
// Saídas: apenas impressão dos resultados
//==================================================================
function Trapezio_Funcao(f, x0, xn, n, integral_exata)
	h = (xn - x0) / n
	soma_interna = 0

	for i = 1:(n - 1)
		soma_interna = soma_interna + f(x0 + i * h)
	end

	integral_numerica = (h / 2) * (f(x0) + 2 * soma_interna + f(xn))
	//==================================================================
	printf("\n/////////////////////////////////////////////////////////\n")
	printf(" Integração numérica pelo método do Trapézio (função):\n")
	printf(" Intervalo de %g a %g com %d subintervalos (n = %d).\n", x0, xn, n + 1, n)
	printf(" Integral aproximada: %f\n", integral_numerica)
	erro_percentual = abs((integral_exata - integral_numerica) / integral_exata) * 100
	printf(" Erro relativo percentual: %.6f %%\n", erro_percentual)
endfunction
