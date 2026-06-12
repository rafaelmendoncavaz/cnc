//=========================================
// AJUSTE POLINOMIAL POR MINIMOS QUADRADOS
//=========================================

clear()
clc()

caminho = get_absolute_file_path("a2-q2.sce")
exec(caminho + "ajuste-poly-min-quadrados.sce", -1)
exec(caminho + "plot_ajuste-poly-reg.sce", -1)

//=========================================
// [1] ENTRADA DE DADOS
//=========================================
X = [1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0]
Y = [10.5, 18.0, 24.2, 29.7, 34.0, 37.1, 39.0]

//=========================================
// [2] IMPRESSÃO DA TABELA DE DADOS
//=========================================
printf("\n[1] TABELA DE DADOS UTILIZADA NO AJUSTE:\n\n")
for i = 1:length(X)
    printf("   x(%d) = %10.6f     y(%d) = %10.6f\n", i, X(i), i, Y(i))
end

//=========================================
// [5] ESCOLHA DA ORDEM DO POLINOMIO
//=========================================
printf("\n[2] ESCOLHA DA ORDEM DO POLINOMIO\n\n")
ORDEM = input("Escolha a ORDEM do Polinômio (1 a 3): ")

//=========================================
// [6] EXECUÇÃO DO AJUSTE
//=========================================
[Pol_ajuste, SSR, R2] = AjustePolinomialMQM(X, Y, ORDEM)

//=========================================
// [7] GERAÇÃO DO GRÁFICO
//=========================================
plotar_ajuste_polinomial(X, Y, Pol_ajuste, ORDEM)

printf("\n***** FIM DO AJUSTE POLINOMIAL *****\n")
