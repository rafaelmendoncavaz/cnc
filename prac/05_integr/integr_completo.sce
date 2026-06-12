//==================================================================
// Função: Trapezio_Funcao
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
caminho = get_absolute_file_path("integr_completo.sce")

exec(caminho + "01_trapezio-dados.sce", -1)
exec(caminho + "02_simpson-1-3-dados.sce", -1)
exec(caminho + "03_simpson-3-8-dados.sce", -1)
exec(caminho + "04_trapezio-funcao.sce", -1)

//==================================================================
// Dados para problemas com tabelas
//==================================================================
X = [0, 2, 4, 6]
Y = [1, 9, -65, 217]

//==================================================================
// Dados para problemas com função
//==================================================================
deff('y = f(x)', 'y = 1 + 97.5 * x - 65 * x^2 + 9.125 * x^3')
x0 = 0.0
xn = 6.0
// conferir com https://www.wolframalpha.com/input?i=integrate
integral_exata = intg(x0, xn, f) 
n = 1000 // número de subintervalos para trapézio para funções

//==================================================================
// Execução dos métodos com dados tabulados + função
//==================================================================
printf("\n>>> Método do Trapézio Generalizado (dados tabulados): ")
Trapezio_Dados(X, Y, integral_exata)

printf("\n>>> Método de Simpson 1/3 Generalizado (dados tabulados): ")
Simpson_1_3_Dados(X, Y, integral_exata)

printf("\n>>> Método de Simpson 3/8 Generalizado (dados tabulados): ")
Simpson_3_8_Dados(X, Y, integral_exata)

printf("\n>>> Método do Trapézio Generalizado (função): ")
Trapezio_Funcao(f, x0, xn, n, integral_exata)
printf("\n/////////// FIM DA INTEGRAÇÃO NUMÉRICA //////////////\n")
