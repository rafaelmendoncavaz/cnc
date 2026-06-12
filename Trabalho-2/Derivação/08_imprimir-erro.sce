//==================================================================
// Função: Imprimir_Erro
// Objetivo: Calcular e imprimir o erro relativo percentual entre a derivada
//			exata e a derivada numérica
//==================================================================
// Entradas:
//	derivada_exata 		: valor exato da derivada
// derivada_numerica	: valor obtido numericamente
//==================================================================
// Saídas
// apenas impressão de resultados
//==================================================================
function Imprimir_Erro(derivada_exata, derivada_numerica)
	erro_percentual = abs((derivada_exata - derivada_numerica) / derivada_exata) * 100
	printf(" Erro relativo percentual:\n")
	printf(" |(%0.6f - %0.6f) / %0.6f| * 100%% = %0.6f%%\n", ...
		derivada_exata, derivada_numerica, derivada_exata, erro_percentual)
endfunction
//==================================================================
