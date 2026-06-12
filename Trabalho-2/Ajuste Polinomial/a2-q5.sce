//=========================================
// AJUSTE POLINOMIAL POR MINIMOS QUADRADOS
//=========================================

clear()
clc()

caminho = get_absolute_file_path("a2-q5.sce")
exec(caminho + "ajuste-poly-min-quadrados.sce", -1)
exec(caminho + "plot_ajuste-poly-reg.sce", -1)

//=========================================
// [1] ENTRADA DE DADOS
//=========================================
printf("\n[1] ESCOLHA O ARQUIVO A SER LIDO:\n")
printf("   1 = dados_ajuste_linear.csv\n")
printf("   2 = dados_ajuste_quadratico.csv\n")
printf("   3 = dados_ajuste_cubico.csv\n\n")

arquivo = input("Digite o arquivo desejado(1 a 3): ")
select arquivo
case 1 then arquivo = "dados_ajuste_linear.csv"
case 2 then arquivo = "dados_ajuste_quadratico.csv"
case 3 then arquivo = "dados_ajuste_cubico.csv"
else
    error("Opção Inválida. Escolha novamente.")
end

CSV = caminho + arquivo
dados = csvRead(CSV)
dados = dados(2:$, :)

// [1.1] VALIDAR A ESTRUTURA DO ARQUIVO (2 COLUNAS)
if size(dados, 2) == 2 then
    X = dados(:, 1) // COLUNA 1 = X
    Y = dados(:, 2) // COLUNA 2 = Y
    printf("\n[INFO] Dados carregados do arquivo CSV: %s\n", CSV)
else
    printf("\n[ERRO] O arquivo CSV deve ter exatamente 2 colunas (X, Y). Colunas encontradas: %d\n", size(dados, 2))
    abort
end

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
