//=========================================
// AJUSTE POLINOMIAL POR MINIMOS QUADRADOS
//=========================================

clear()
clc()

caminho = get_absolute_file_path("ajuste-poly-min-quadrados.sce")
exec(caminho + "plot_ajuste-poly-reg.sce", -1)

printf("\n***** AJUSTE POLINOMIAL POR MINIMOS QUADRADOS *****\n")

//=========================================
// [1] ENTRADA DE DADOS
//=========================================
/*
CSV = caminho + "dados_ajuste_quadratico.csv"
dados = csvRead(CSV)

// [1.1] VALIDAR A ESTRUTURA DO ARQUIVO (2 COLUNAS)
if size(dados, 2) == 2 then
    X = dados(:, 1) // COLUNA 1 = X
    Y = dados(:, 2) // COLUNA 2 = Y
    printf("\n[INFO] Dados carregados do arquivo CSV: %s\n", CSV)
else
    printf("\n[ERRO] O arquivo CSV deve ter exatamente 2 colunas (X, Y). Colunas encontradas: %d\n", size(dados, 2))
    abort
end
*/
// EX 4.15 / EX 4.18
X = [1.3, 3.4, 5.1, 6.8, 8.0]
Y = [2.0, 5.2, 3.8, 6.1, 5.8]

// EX 4.16
// X = [-1, -0.75, -0.5, -0.25, 0.0, 0.25, 0.5, 0.75, 1]
// Y = [2.1, 1.3, 1.1, 0.2, 0, 0.5, 0.6, 1.5, 2.2]

// EX 4.20
// X = [-1, -0.75, -0.6, -0.5, -0.3, 0, 0.2, 0.4, 0.5, 0.7, 1]
// Y = [2.05, 1.153, 0.45, 0.4, 0.5, 0, 0.2, 0.6, 0.512, 1.2, 2.05]

//=========================================
// [2] IMPRESSÃO DA TABELA DE DADOS
//=========================================
printf("\n[1] TABELA DE DADOS UTILIZADA NO AJUSTE:\n\n")
for i = 1:length(X)
    printf("   x(%d) = %10.6f     y(%d) = %10.6f\n", i, X(i), i, Y(i))
end
//=========================================
// [3] FUNÇÃO: AJUSTE POLINOMIAL POR MINIMOS QUADRADOS
//=========================================
function [Pol_ajuste, SSR, R2] = AjustePolinomialMQM(X, Y, ordem)
    n = length(X)
    grau = ordem + 1
    aux = 0

    //=========================================
    // [3.1] Construção da matriz do sistema normal
    //=========================================
    for i = 1:grau
        for j = 1:grau
            for k = 1:n
                aux = aux + (X(k).^((i - 1) + (j - 1)))
            end

            A(i,j) = aux
            aux = 0
        end
    end

    format("v", 9)
    printf("\n[2] MATRIZ DO SISTEMA NORMAL:\n")
    disp(A)

    //=========================================
    // [3.2] Construção do vetor dos termos independentes
    //=========================================
    aux = 0
    for i = 1:grau
        for k = 1:n
            aux = aux + (X(k).^(i - 1)) * Y(k)
        end

        B(i) = aux
        aux = 0
    end
    printf("\n[3] VETOR DOS TERMOS INDEPENDENTES:\n")
    disp(B)

    //=========================================
    // [3.3] Resolução do Sistema Linear
    //=========================================
    M = A \ B
    printf("\n[4] COEFICIENTE DO POLINOMIO DE AJUSTE:\n")
    disp(M)

    //=========================================
    // [3.4] Construção do Polinomio Ajustado
    //=========================================
    Pol_ajuste = poly(M, "x", "c")
    printf("\n[5] POLINOMIO AJUSTADO POR MQM:\n")
    disp(Pol_ajuste)

    //=========================================
    // [3.5] Avaliação da qualidade do ajuste
    //=========================================
    [SSR, R2] = calcular_desvios(X, Y, Pol_ajuste)
endfunction

//=========================================
// [4] FUNÇÃO: CALCULO DOS DESVIOS E DO COEFICIENTE R2
//=========================================
function [SSR, R2] = calcular_desvios(X, Y, polinomio)
    n = length(X)
    Ybar = sum(Y) / n
    SSR = 0
    SST = 0
    for i = 1:n
        ajuste = horner(polinomio, X(i))

        res_i = (Y(i) - ajuste)^2
        SSR = SSR + res_i

        sst_i = (Y(i) - Ybar)^2
        SST = SST + sst_i
    end
    R2 = 1 - SSR / SST

    printf("\n[6] QUALIDADE DO AJUSTE:\n")
    //printf("     Soma dos desvios quadraticos (SSR) = %.6f\n", SSR)
    printf("     Coeficiente de determinação R2    = %.6f\n", R2)
endfunction

//=========================================
// [5] ESCOLHA DA ORDEM DO POLINOMIO
//=========================================
ORDEM = 1

//=========================================
// [6] EXECUÇÃO DO AJUSTE
//=========================================
[Pol_ajuste, SSR, R2] = AjustePolinomialMQM(X, Y, ORDEM)

//=========================================
// [7] GERAÇÃO DO GRÁFICO
//=========================================
plotar_ajuste_polinomial(X, Y, Pol_ajuste)

printf("\n***** FIM DO AJUSTE POLINOMIAL *****\n")
