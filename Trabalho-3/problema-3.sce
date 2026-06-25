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
caminho = get_absolute_file_path("problema-3.sce")

exec(caminho + "/Integral/01_trapezio-dados.sce", -1)
exec(caminho + "/Integral/02_simpson-1-3-dados.sce", -1)
exec(caminho + "/Integral/03_simpson-3-8-dados.sce", -1)
exec(caminho + "/Integral/04_trapezio-funcao.sce", -1)

//==================================================================
// DADOS PARA PROBLEMAS COM TABELAS
// Caso não tenha os dados, apenas comente os métodos que utilizam dados
// Ex.: Simpson e Trapezio_Dados
//==================================================================
// Trabalho 3: Problema 3
// [1] ENTRADA DE DADOS
X = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
Y = [0.000, 0.590, 0.949, 0.951, 0.589, 0.01]

// [2] FUNÇÕES MODELADAS E/OU APROXIMADAS
// Função Modelada
deff('y = f(x)', 'y = sin(%pi * x)')
// Polinomio Obtido por Interpolação Polinomial
deff('y = f1(x)', 'y = 0.911458*x^5 + 1.276042*x^4 - 5.067708*x^3 - 0.313542*x^2 + 3.203750*x')
// Polinomio Ajustado por MQM Ordem 3
deff('y = f2(x)', 'y = 0.056713*x^3 - 3.981944*x^2 + 3.934954*x - 0.009611')

x0 = 0
xn = 1

// conferir com https://www.wolframalpha.com/input?i=integrate
// ou https://www.integral-calculator.com/
integral_exata = 0.636620
// integral do polinomio obtido por interpolação polinomial
integral_ref1 = 0.637552
// integral do polinomio obtido por ajuste MQM ordem 3
integral_ref2 = 0.644729

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
