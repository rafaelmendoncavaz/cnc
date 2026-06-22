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
// DADOS PARA PROBLEMAS COM TABELAS
// Caso não tenha os dados, apenas comente os métodos que utilizam dados
// Ex.: Simpson e Trapezio_Dados
//==================================================================
// X = [0, 2, 4, 6]
// Y = [1, 9, -65, 217]
//==================================================================
// Também pode-se criar valores dentro do intervalo [x0, xn] para X
// E aplicando os valores em X na função, obter valor exato para Y
// Desta forma, pode-se
// Ex. 
// X = [0.10, 0.15, 0.20, 0.25, 0.30]
// Y = [0.090333, 0.128623, 0.162657, 0.192678, 0.218927]
//==================================================================
// Também pode-se executar sem os dados, utilizando apenas os limites superior
// e inferior, e o valor da integral exata, mudando o numero de intervalos
//==================================================================
// Dados para problemas com função
//==================================================================
// Supondo que nao se tenha a funcao, obtenha o polinomio utilizando os metodos
// de interpolacao polinomial
deff('y = f(x)', 'y = exp(-x^2)')

// Intervalo dos Dados (Area a descobrir)
x0 = 0
xn = 1

// conferir com https://www.wolframalpha.com/input?i=integrate
// ou https://www.integral-calculator.com/
// integral_exata = intg(x0, xn, f) 
integral_exata = 0.746824
n = 10 // número de subintervalos para trapézio para funções
// printf("Func Intg: %.3f\n", integral_exata)

//==================================================================
// Execução dos métodos com dados tabulados + função
//==================================================================
// printf("\n>>> Método do Trapézio Generalizado (dados tabulados): ")
// Trapezio_Dados(X, Y, integral_exata)

// printf("\n>>> Método de Simpson 1/3 Generalizado (dados tabulados): ")
// Simpson_1_3_Dados(X, Y, integral_exata)

// printf("\n>>> Método de Simpson 3/8 Generalizado (dados tabulados): ")
// Simpson_3_8_Dados(X, Y, integral_exata)

printf("\n>>> Método do Trapézio Generalizado (função): ")
Trapezio_Funcao(f, x0, xn, n, integral_exata)
printf("\n/////////// FIM DA INTEGRAÇÃO NUMÉRICA //////////////\n")
