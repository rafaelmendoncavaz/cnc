//=========================================
// AJUSTE POLINOMIAL POR MINIMOS QUADRADOS
//=========================================

clear()
clc()

caminho = get_absolute_file_path("problema-1.sce")
exec(caminho + "plot_ajuste-poly-reg.sce", -1)

printf("\n***** AJUSTE POLINOMIAL POR MINIMOS QUADRADOS *****\n")

//=========================================
// [1] ENTRADA DE DADOS
//=========================================
X = [0, 1, 2, 3, 4, 5]
Y = [0.01, 0.69, 1.09, 1.40, 1.60, 1.79]

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

    coef = coeff(Pol_ajuste)
    grau = length(coef) - 1

    for k = grau:-1:0
        c = coef(k + 1)
        if k == grau then
            printf("%.6f", c)
        else
            if c>= 0 then
                printf(" + %.6f", c)
            else
                printf(" - %.6f", abs(c))
            end
        end

        if k > 1 then
            printf("*x^%d", k)
        elseif k == 1 then
            printf("*x")
        end
    end
    printf("\n")

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
printf("\n[2] ESCOLHA DA ORDEM DO POLINOMIO\n\n")
ORDEM = input("Escolha a ORDEM do Polinômio (1 a 5): ")

//=========================================
// [6] EXECUÇÃO DO AJUSTE
//=========================================
[Pol_ajuste, SSR, R2] = AjustePolinomialMQM(X, Y, ORDEM)

//=========================================
// [7] GERAÇÃO DO GRÁFICO
//=========================================
plotar_ajuste_polinomial(X, Y, Pol_ajuste)

printf("\n***** FIM DO AJUSTE POLINOMIAL *****\n")
