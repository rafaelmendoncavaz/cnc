//==================================================================
// Script principal: integr_completo.sce
//==================================================================
clear()
clc()
printf("\n/////////////////////////////////////////////////////////\n")
printf("\n//////// INTEGRAÇÃO NUMÉRICA - MÓDULO COMPLETO //////////\n")
printf("\n/////////////////////////////////////////////////////////\n")
//==================================================================
// Carregamento das funções modularizadas
//==================================================================
caminho = get_absolute_file_path("problema-1.sce")

exec(caminho + "/Integral/01_trapezio-dados.sce", -1)
exec(caminho + "/Integral/02_simpson-1-3-dados.sce", -1)
exec(caminho + "/Integral/03_simpson-3-8-dados.sce", -1)
exec(caminho + "/Integral/04_trapezio-funcao.sce", -1)

//==================================================================
// DADOS PARA PROBLEMAS COM TABELAS
// Caso não tenha os dados, apenas comente os métodos que utilizam dados
// Ex.: Simpson e Trapezio_Dados
//==================================================================
// Trabalho 3: Problema 1
// [1] ENTRADA DE DADOS
X = [0, 1, 2, 3, 4, 5, 6]
Y = [5.04, 5.93, 12.08, 26.01, 44.91, 70.21, 100.87]

// [2] FUNÇÕES MODELADAS E/OU APROXIMADAS
// Função Modelada
deff('y = f(x)', 'y = 3*x^2 - 2*x + 5')
// Polinomio Obtido por Interpolação Polinomial
deff('y = f1(x)', 'y = -0.022611*x^6 + 0.418917*x^5 - 2.941528*x^4 + 9.631250*x^3 - 11.255861*x^2 + 5.059833*x + 5.040000')
// Polinomio Ajustado por MQM Ordem 2
deff('y = f2(x)', 'y = 3.030238*x^2 - 2.150000*x + 4.921190')

x0 = 0
xn = 6

// conferir com https://www.wolframalpha.com/input?i=integrate
// ou https://www.integral-calculator.com/
integral_exata = 210
// integral do polinomio obtido por interpolação polinomial
integral_ref1 = 210.020977
// integral do polinomio obtido por ajuste MQM ordem 2
integral_ref2 = 209.004276

// número de subintervalos para trapézio usando funções
n = 30

//==================================================================
// Execução dos métodos com dados tabulados + função
//==================================================================
printf("\n>>> Método do Trapézio Generalizado (dados tabulados): ")
Trapezio_Dados(X, Y, integral_exata)

x = length(X) - 1

if modulo(x, 2) == 0 then
	printf("\n>>> Método de Simpson 1/3 Generalizado (dados tabulados): ")
	Simpson_1_3_Dados(X, Y, integral_exata)
else 
	printf("\n>>> Número de Subintervalos Incompativel com os Métodos de Simpson 1/3\n")
end

if modulo(x, 3) == 0 then
	printf("\n>>> Método de Simpson 3/8 Generalizado (dados tabulados): ")
	Simpson_3_8_Dados(X, Y, integral_exata)
else
	printf("\n>>> Número de Subintervalos Incompativel com os Métodos de Simpson 3/8\n")
end

printf("\n>>> Método do Trapézio Generalizado (função modelo): ")
Trapezio_Funcao(f, x0, xn, n, integral_exata)

printf("\n>>> Método do Trapézio Generalizado (função interpolada): ")
Trapezio_Funcao(f1, x0, xn, n, integral_ref1)

printf("\n>>> Método do Trapézio Generalizado (função ajustada): ")
Trapezio_Funcao(f2, x0, xn, n, integral_ref2)

printf("\n/////////// FIM DA INTEGRAÇÃO NUMÉRICA //////////////\n")
