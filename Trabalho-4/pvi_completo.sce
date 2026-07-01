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
caminho = get_absolute_file_path("pvi_completo.sce")

exec(caminho + "01_euler-1a-ordem.sce", -1)
exec(caminho + "02_euler-modif.sce", -1)
exec(caminho + "03_taylor-2a-ordem.sce", -1)
exec(caminho + "04_runge_kutta-3a-ordem.sce", -1)
exec(caminho + "05_runge_kutta-4a-ordem.sce", -1)
exec(caminho + "06_plot-resultados.sce", -1)
//==================================================================
// Exemplos de PVI com soluções conhecidas
//==================================================================
// Ex 6.12
// dy = x - 2y
// d2y = 1 -2x + 4y
// yex = x/2-1/4+5/4*exp(-2*x)
// a = 0.0
// b = 0.5
// x0 = a
// y0 = 1.0

// Ex 6.12+1 
// Obtidos atraves do sistema fornecido
// {y' = x - y + 2
// {y(0.0) = 2.0
// Onde:
// {y(a) = y0
// b = valor para aproximar: y(b)
// dy = x - 1 + 2
// d2y = -x + y - 1
// yex = x + 1 + exp(-x)
// a = 0.0
// b = 1.0
// x0 = a
// y0 = 2.0

// Trabalho 4: Problema 1
// dR(c)/dc = y'
// R(c) = y
// a = 0.0 // R(0.0)
// b = 1.0 // R(1.0)
// x0 = a
// y0 = 50 // R(0.0) = 50
// k = 1.5
// Rmax = 200
// dy = k * (Rmax - y)
// d2y = -k^2 * (Rmax - y)
// yex = Rmax - (Rmax - y0) * exp(-k * x)

// Trabalho 4: Problema 2
// dT(t)/dt = y'
// T(t) = y
// a = 0.0 // T(0)
// b = 5.0 // T(5)
// x0 = a
// y0 = 20 // R(0) = 20
// dy = (50 - y) / 10
// d2y =  - (1 / 10) * (y0 - y) / 10
// yex = 50 - 30 * exp(-x / 10)

// Trabalho 4: Problema 3
// dV(t)/dt = y'
// V(t) = y
// a = 0.0 // V(0)
// b = 3.0 // V(3)
// x0 = a
// y0 = 0 // V(0) = 0
// dy = (5 - y) / 2
// d2y = 0 - (1 / 2) * ((5 - y) / 2)
// yex = 5 - 5 * exp(-x / 2)

// Trabalho 4: Problema 4
// dN(t)/dt = f'
// N(t) = y
// a = 0.0 // N(0)
// b = 6.0 // N(3)
// x0 = a
// y0 = 25 // N(0) = 25
// dy = 0.8 * x - 0.1 * y
// d2y = (4/5) - (1/10) * 0.8 * x - 0.1 * y
// yex = 8 * x - 80 + 105 * exp(-0.1 * x)

// Trabalho 4: Problema 5
// dS(t)/dt = y'
// S(t) = y
a = 0.0 // S(0)
b = 3.0 // S(3)
x0 = a
y0 = 0 // S(0) = 0
// dy = log(x + 1)
// d2y = (1 / (x + 1)) + 0 * log(x + 1)
// yex = (x + 1) * log(x + 1) - x

//==================================================================
// Passo ou nr de subintervalos, que deve ser adaptado para cada problema
//==================================================================
h = 0.2 // Espaçamento
n = round((b - a) / h)
//==================================================================
// Definição das EDOs dos PVI + Solução exata, quando disponível
//==================================================================
// Derivada Primeira
function dy = f(x, y)
	dy = log(x + 1)
endfunction

// Derivada Segunda
// https://www.derivative-calculator.net/
// f'(x) + f'(y) * f
function d2y = df(x, y)
	d2y =  (1 / ( x + 1)) + 0 * log(x + 1)
endfunction

// Solução Analítica
// Encontrada através da Integração da função modelo nos intervalos entre a e b
function yex = y_exata(x)
	yex = (x + 1) * log(x + 1) - x
endfunction
//==================================================================
// Métodos de solução: 
// EULER
// EULER MODIFICADO
// TAYLOR 2ª ORDEM
// RUNGE-KUTTA 3ª ORDEM
// RUNGE-KUTTA 4ª ORDEM
//==================================================================
[x1, y1] = euler_1a_ordem(f, x0, y0, h, n)
[x2, y2] = euler_modificado(f, x0, y0, h, n)
[x3, y3] = taylor_2a_ordem(f, df, x0, y0, h, n)
[x4, y4] = rk_3a_ordem(f, x0, y0, h, n)
[x5, y5] = rk_4a_ordem(f, x0, y0, h, n)
//==================================================================
// Solução Exata
//==================================================================
yex = y_exata(x1)
//==================================================================
// Cálculo dos Erros
//==================================================================
printf("\n\n================= ERROS FINAIS EM y(**) ==================\n")
mprintf(" Metodo                  y(**)          Erro Relativo (%%)\n")
mprintf("----------------------------------------------------------\n")
mprintf(" Euler 1ª Ordem       %9.6f     %10.6f\n", y1($), 100 * abs((y1($) - yex($)) / yex($)))
mprintf(" Euler Modificado     %9.6f     %10.6f\n", y2($), 100 * abs((y2($) - yex($)) / yex($)))
mprintf(" Taylor 2ª Ordem      %9.6f     %10.6f\n", y3($), 100 * abs((y3($) - yex($)) / yex($)))
mprintf(" Runge-Kutta 3ª Ordem %9.6f     %10.6f\n", y4($), 100 * abs((y4($) - yex($)) / yex($)))
mprintf(" Runge-Kutta 4ª Ordem %9.6f     %10.6f\n", y5($), 100 * abs((y5($) - yex($)) / yex($)))
mprintf("----------------------------------------------------------\n")
mprintf(" Solução Exata        %9.6f\n", yex($))
printf("===========================================================\n\n")
// ==================================================================
// Gráfico Comparativo
// ==================================================================
clf()
plot(x1, y1, 'r-o', x2, y2, 'g-x', x3, y3, 'm-+', ...
	x4, y4, 'c-s', x5, y5, 'b-*', x1, yex, 'k--')

xgrid(1)
xtitle("Comparação de Métodos para o PVI: XXXXXXXXXXX", "Valores do Domínio", "Solução y(x)")
legend(["Euler 1ª Ordem", "Euler Modificado", "Tylor 2ª Ordem", ...
	"Runge-Kutta 3ª Ordem", "Runge-Kutta 4ª Ordem", ...
	"Solução Exata"], "in_upper_right")
// ==================================================================
