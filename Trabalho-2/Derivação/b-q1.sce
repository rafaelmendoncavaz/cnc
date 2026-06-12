//==================================================================
// Script Principal: deriv_completo.sce
//==================================================================
clear()
clc()

printf("\n/////////////////////////////////////////////////////////\n")
printf("\n////// DIFERENCIAÇÃO NUMÉRICA - MÓDULO COMPLETO /////////\n")
printf("\n/////////////////////////////////////////////////////////\n")
//==================================================================
// Carregamento das funções modularizadas
//==================================================================
caminho = get_absolute_file_path("b-q1.sce")

exec(caminho + "01_progressiva-1a-ordem.sce", -1)
exec(caminho + "02_regressiva-1a-ordem.sce", -1)
exec(caminho + "03_centrada-2a-ordem.sce", -1)
exec(caminho + "04_centrada-2a-ordem-2.sce", -1)
exec(caminho + "05_lagrange-1o-caso.sce", -1)
exec(caminho + "06_lagrange-2o-caso.sce", -1)
exec(caminho + "07_lagrange-3o-caso.sce", -1)
exec(caminho + "08_imprimir-erro.sce", -1)
exec(caminho + "09_erro-truncamento.sce", -1)
//==================================================================
// Entrada de dados
//==================================================================
X = [1.6, 1.8, 2.0, 2.2, 2.4]
Y = [3.244909, 3.583519, 3.953032, 4.356755, 4.798624]
k = 3 	// indice do ponto a ser avaliado
x = 2.0 // valor a ser calculado

// Calcular derivadas exatas: https://www.derivative-calculator.net/
// Derivadas exatas no ponto de interesse da função = sqrt(x^3+9)

// f(t)
deff('y = f(x)', 'y = sqrt(x^3+9)')
// f'(t)
deff('y = f1(x)', 'y = (3 * x^2) / (2 * sqrt(x^3 + 9))')
// f''(t)
deff('y = f2(x)', 'y = (3 * x^4 + 108 * x) / (4 * (x^3 + 9)^(3 / 2))')
// f'''(t)
deff('y = f3(x)', 'y = -(3 * x^6 + 540 * x^3 - 1944) / (8 * (x^3 + 9)^(5 / 2))')
// f''''(t)
deff('y = f4(x)', 'y = (9 * x^2 * (x^6 + 504 * x^3 - 6480)) / (16 * (x^3 + 9)^(7 / 2))')

derivada_1a_exata = f1(x) // 1.455214
derivada_2a_exata = f2(x) // 0.941609
derivada_3a_exata = f3(x) // -0.26939
derivada_4a_exata = f4(x) // -0.26480

//==================================================================
// Execução dos métodos
//==================================================================
printf("\n>>> Progressiva de 1ª Ordem: ")
Progressiva_1a_Ordem(X, Y, k, derivada_1a_exata, derivada_2a_exata)

printf("\n>>> Regressiva de 1ª Ordem: ")
Regressiva_1a_Ordem(X, Y, k, derivada_1a_exata, derivada_2a_exata)

printf("\n>>> Centrada de 2ª Ordem (1ª Derivada): ")
Centrada_2a_Ordem_1a(X, Y, k, derivada_1a_exata, derivada_3a_exata)

printf("\n>>> Centrada de 2ª Ordem (2ª Derivada): ")
Centrada_2a_Ordem_2a(X, Y, k, derivada_2a_exata, derivada_4a_exata)

printf("\n>>> Lagrange - 1º Caso: ")
Lagrange_1o_Caso(X, Y, k, derivada_1a_exata)

printf("\n>>> Lagrange - 2º Caso: ")
Lagrange_2o_Caso(X, Y, k, derivada_1a_exata)

printf("\n>>> Lagrange - 3º Caso: ")
Lagrange_3o_Caso(X, Y, k, derivada_1a_exata)
printf("\n/////////// FIM DA DIFERENCIAÇÃO NUMÉRICA //////////////\n")
