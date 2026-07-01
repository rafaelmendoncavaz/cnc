//==================================================================
// PROBLEMA DE VALOR INICIAL - COMPLETO
//==================================================================
clear()
clc()
printf("\n/////////////////////////////////////////////////////////\n")
printf("\n/// EDOs: PROBLEMA DE VALOR INICIAL - MÓDULO COMPLETO ///\n")
printf("\n/////////////////////////////////////////////////////////\n")
//==================================================================
// Carregamento dos metodos e da função de visualização
//==================================================================
caminho = get_absolute_file_path("problema-4.sce")

exec(caminho + "01_euler-1a-ordem.sce", -1)
exec(caminho + "02_euler-modif.sce", -1)
exec(caminho + "03_taylor-2a-ordem.sce", -1)
exec(caminho + "04_runge_kutta-3a-ordem.sce", -1)
exec(caminho + "05_runge_kutta-4a-ordem.sce", -1)
exec(caminho + "06_plot-resultados.sce", -1)
//==================================================================
// Entrada de dados
//==================================================================
// Trabalho 4: Problema 4
// dN(t)/dt = f'
// N(t) = y
a = 0.0 // N(0)
b = 6.0 // N(3)
x0 = a
y0 = 25 // N(0) = 25
// dy = 0.8 * x - 0.1 * y
// d2y = (4/5) - (1/10) * 0.8 * x - 0.1 * y
// yex = 8 * x - 80 + 105 * exp(-0.1 * x)

//==================================================================
// Passo ou nr de subintervalos, que deve ser adaptado para cada problema
//==================================================================
h = [0.01, 0.1, 0.2] // Espaçamento
//==================================================================
// Listas para armazenamento de resultados
//==================================================================
X = list()
Y1 = list()
Y2 = list()
Y3 = list()
Y4 = list()
Y5 = list()
YEX = list()
//==================================================================
// Definição das EDOs dos PVI + Solução exata, quando disponível
//==================================================================
// Derivada Primeira
function dy = f(x, y)
	dy = 0.8 * x - 0.1 * y
endfunction

// Derivada Segunda
// https://www.derivative-calculator.net/
// f'(x) + f'(y) * f
function d2y = df(x, y)
	d2y =  (4/5) - (1/10) * 0.8 * x - 0.1 * y
endfunction

// Solução Analítica
// Encontrada através da Integração da função modelo nos intervalos entre a e b
function yex = y_exata(x)
	yex = 8 * x - 80 + 105 * exp(-0.1 * x)
endfunction
//==================================================================
// Métodos de solução: 
// EULER
// EULER MODIFICADO
// TAYLOR 2ª ORDEM
// RUNGE-KUTTA 3ª ORDEM
// RUNGE-KUTTA 4ª ORDEM
//==================================================================
for i = 1:length(h)
	passo = h(i)
	n = round((b - a) / passo)

	[x1, y1] = euler_1a_ordem(f, x0, y0, passo, n)
	[x2, y2] = euler_modificado(f, x0, y0, passo, n)
	[x3, y3] = taylor_2a_ordem(f, df, x0, y0, passo, n)
	[x4, y4] = rk_3a_ordem(f, x0, y0, passo, n)
	[x5, y5] = rk_4a_ordem(f, x0, y0, passo, n)
	//==================================================================
	// Solução Exata
	//==================================================================
	yex = y_exata(x1)
	//==================================================================
	// Armazenamento de resultados
	//==================================================================
	X($+1) = x1
	Y1($+1) = y1
	Y2($+1) = y2
	Y3($+1) = y3
	Y4($+1) = y4
	Y5($+1) = y5
	YEX($+1) = yex
	//==================================================================
	// Cálculo dos Erros
	//==================================================================
	printf("\n\n================= ERROS FINAIS EM y(%.1f) ==================\n", b)
	printf("===========================================================\n")
	printf(">>> Tamanho do passo: %.2f\n", h(i))
	printf("===========================================================\n")
	mprintf(" Metodo               y(%.1f)           Erro Relativo (%%)\n", b)
	mprintf("-----------------------------------------------------------\n")
	mprintf(" Euler 1ª Ordem       %9.6f     %10.6f\n", y1($), 100 * abs((y1($) - yex($)) / yex($)))
	mprintf(" Euler Modificado     %9.6f     %10.6f\n", y2($), 100 * abs((y2($) - yex($)) / yex($)))
	mprintf(" Taylor 2ª Ordem      %9.6f     %10.6f\n", y3($), 100 * abs((y3($) - yex($)) / yex($)))
	mprintf(" Runge-Kutta 3ª Ordem %9.6f     %10.6f\n", y4($), 100 * abs((y4($) - yex($)) / yex($)))
	mprintf(" Runge-Kutta 4ª Ordem %9.6f     %10.6f\n", y5($), 100 * abs((y5($) - yex($)) / yex($)))
	mprintf("-----------------------------------------------------------\n")
	mprintf(" Solução Exata        %9.6f\n", yex($))
	printf("===========================================================\n\n")
end
// ==================================================================
// Gráfico Comparativo
// ==================================================================
printf("===========================================================\n")
printf("***** GRÁFICO COMPARATIVO *****\n")
printf(" >>> (1) h = 0.01\n")
printf(" >>> (2) h = 0.1\n")
printf(" >>> (3) h = 0.2\n")
printf(" >>> (0) Sair\n")
printf("===========================================================\n")

modo = input("Selecione a opção > ")

while (modo <> 0)
	if (modo > 0 & modo <= length(h)) then
		clf()
		plot(X(modo), Y1(modo), 'r-o', X(modo), Y2(modo), 'g-x', X(modo), Y3(modo), 'm-+', ...
			X(modo), Y4(modo), 'c-s', X(modo), Y5(modo), 'b-*', X(modo), YEX(modo), 'k--')

		xgrid(1)
		xtitle("Comparação de Métodos para o PVI em h = " + string(h(modo)) + ": dN(t)/dt = 0.8t - 0.1N(t)", "Valores do Domínio = [0, 6]", "Solução y(x)")
		legend(["Euler 1ª Ordem", "Euler Modificado", "Tylor 2ª Ordem", ...
			"Runge-Kutta 3ª Ordem", "Runge-Kutta 4ª Ordem", ...
			"Solução Exata"], "in_upper_right")
	else
		disp("Opção Inválida! Selecione de 1 a 3!\n")
	end

	modo = input("Selecione outra opção (0 para sair) > ")
end

// ==================================================================
