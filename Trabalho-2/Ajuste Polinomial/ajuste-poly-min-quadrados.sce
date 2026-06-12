//=========================================
// AJUSTE POLINOMIAL POR MINIMOS QUADRADOS
//=========================================

clear()
clc()

caminho = get_absolute_file_path("ajuste-poly-min-quadrados.sce")
exec(caminho + "plot_ajuste-poly-reg.sce", -1)

printf("\n***** AJUSTE POLINOMIAL POR MINIMOS QUADRADOS *****\n")

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
