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

exec(caminho + "/Integral/01_trapezio-dados.sce", -1)
exec(caminho + "/Integral/02_simpson-1-3-dados.sce", -1)
exec(caminho + "/Integral/03_simpson-3-8-dados.sce", -1)
exec(caminho + "/Integral/04_trapezio-funcao.sce", -1)

//==================================================================
// DADOS PARA PROBLEMAS COM TABELAS
// Caso não tenha os dados, apenas comente os métodos que utilizam dados
// Ex.: Simpson e Trapezio_Dados
//==================================================================
// X = [0, 1, 2, 3, 4, 5, 6]
// Y = [5.04, 5.93, 12.08, 26.01, 44.91, 70.21, 100.87]

// Trabalho 3: Problema 2
// X = [0, 1, 2, 3, 4, 5]
// Y = [0.01, 0.69, 1.09, 1.40, 1.60, 1.79]
// // função modelada
// deff('y = f(x)', 'y = log(x + 1)')
// // Polinomio obtido por interpolação polinomial
// deff('y = f1(x)', 'y = 0.002750*x^5 - 0.036250*x^4 + 0.180417*x^3 - 0.468750*x^2 + 1.001833*x + 0.010000')
// // Polinomio ajustado por MQM Ordem 3
// deff('y = f2(x)', 'y = 0.011944*x^3 - 0.147619*x^2 + 0.794960*x + 0.014524')

// x0 = 0
// xn = 5

// integral_exata = 5.750557
// // integral do polinomio obtido por interpolação polinomial
// integral_ref1 = 5.737032
// // integral do polinomio obtido por ajuste MQM ordem 3
// integral_ref2 = 5.725078

// n = 30

// Trabalho 3: Problema 3
// X = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
// Y = [0.000, 0.590, 0.949, 0.951, 0.589, 0.01]
// // função modelada
// deff('y = f(x)', 'y = sin(%pi * x)')
// // função obtida pelo método de interpolação polinomial
// deff('y = f1(x)', 'y = 0.911458*x^5 + 1.276042*x^4 - 5.067708*x^3 - 0.313542*x^2 + 3.203750*x')
// // função obtida pelo método de ajuste MQM ordem 3
// deff('y = f2(x)', 'y = 0.056713*x^3 - 3.981944*x^2 + 3.934954*x - 0.009611')

// integral_exata = 0.636620
// integral_ref1 = 0.637552
// integral_ref2 = 0.644729

// x0 = 0
// xn = 1

// Trabalho 3: Problema 4
// X = [0, 1, 2, 3, 4, 5]
// Y = [1.00, 0.49, 0.20, 0.099, 0.060, 0.038]

// x0 = 0
// xn = 5

// // função modelada
// deff('y = f(x)', 'y = 1 / (1 + x^2)')
// integral_exata = 1.373400
// // função obtida pelo método de interpolação polinomial
// deff ('y =  f1(x)', 'y = 0.001483*x^5 - 0.018833*x^4 + 0.070750*x^3 + 0.007333*x^2 - 0.570733*x + 1.000000')
// integral_ref1 = 1.317421
// // função obtida pelo método de ajuste MQM ordem 3
// deff('y = f2(x)', 'y = -0.012926*x^3 + 0.158444*x^2 - 0.661757*x + 1.001206')
// integral_ref2 = 1.316213

// Trabalho 3: Problema 5
X = [0, 1, 2, 3, 4, 5, 6]
Y = [2.01, 1.24, 0.28, 0.00, 0.17, 0.40, 0.52]

x0 = 0
xn = 6

// função modelada
deff('y = f(x)', 'y = exp(-0.2 * x) * (1 + cos(x))')
integral_exata = 3.549800
// função obtida pelo método de interpolação polinomial
deff('y = f1(x)', 'y = -0.000778*x^6 + 0.019500*x^5 - 0.190278*x^4 + 0.869167*x^3 - 1.638944*x^2 + 0.171333*x + 2.010000')
integral_ref1 = 3.348901
// função obtida pelo método de ajuste MQM ordem 5
deff('y = f2(x)', 'y = 0.005500*x^5 - 0.095530*x^4 + 0.572197*x^3 - 1.216894*x^2 - 0.039515*x + 2.010606')
integral_ref2 = 3.327570

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
// deff('y = f(x)', 'y = log(x + 1')

// Intervalo dos Dados (Area a descobrir)
// x0 = 0
// xn = 5

// conferir com https://www.wolframalpha.com/input?i=integrate
// ou https://www.integral-calculator.com/
// integral_exata = intg(x0, xn, f) 
// integral_exata = 5.750557

// número de subintervalos para trapézio para funções
n = 30 
// printf("Func Intg: %.3f\n", integral_exata)

//==================================================================
// Execução dos métodos com dados tabulados + função
//==================================================================
printf("\n>>> Método do Trapézio Generalizado (dados tabulados): ")
Trapezio_Dados(X, Y, integral_exata)

printf("\n>>> Método de Simpson 1/3 Generalizado (dados tabulados): ")
Simpson_1_3_Dados(X, Y, integral_exata)

printf("\n>>> Método de Simpson 3/8 Generalizado (dados tabulados): ")
Simpson_3_8_Dados(X, Y, integral_exata)

printf("\n>>> Método do Trapézio Generalizado (função modelo): ")
Trapezio_Funcao(f, x0, xn, n, integral_exata)

printf("\n>>> Método do Trapézio Generalizado (função interpolada): ")
Trapezio_Funcao(f1, x0, xn, n, integral_ref1)

printf("\n>>> Método do Trapézio Generalizado (função ajustada): ")
Trapezio_Funcao(f2, x0, xn, n, integral_ref2)
printf("\n/////////// FIM DA INTEGRAÇÃO NUMÉRICA //////////////\n")
