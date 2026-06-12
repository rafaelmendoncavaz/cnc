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
caminho = get_absolute_file_path("deriv_completo.sce")

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
X = [1.8, 1.9, 2.0, 2.1, 2.2]
Y = [10.889365, 12.703199, 14.77812, 17.148957, 19.955030]
k = 3 	// indice do ponto a ser avaliado

// Derivadas exatas no ponto de interesse da função = x.exp(x)
x = 2.0
derivada_1a_exata = (x + 1) * exp(x) // derivada_1a = 22.167168
derivada_2a_exata = (x + 2) * exp(x) // derivada_2a = 29.556224
derivada_3a_exata = (x + 3) * exp(x) // derivada_3a = 36.945270
derivada_4a_exata = (x + 4) * exp(x) // derivada_4a = 44.334337

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
Centrada_2a_Ordem_2a(X, Y, k, derivada_1a_exata, derivada_3a_exata)

printf("\n>>> Lagrange - 1º Caso: ")
Lagrange_1o_Caso(X, Y, k, derivada_1a_exata)

printf("\n>>> Lagrange - 2º Caso: ")
Lagrange_2o_Caso(X, Y, k, derivada_1a_exata)

printf("\n>>> Lagrange - 3º Caso: ")
Lagrange_3o_Caso(X, Y, k, derivada_1a_exata)
printf("\n/////////// FIM DA DIFERENCIAÇÃO NUMÉRICA //////////////\n")
