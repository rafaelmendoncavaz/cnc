// INTERPOLA;'AO POLINOMIAL POR NEWTON - VER. MODULARIZADA

clc()
clear()
clf()

printf("\n** INTERPOLAÇÃO PELO MÉTODO DE NEWTON - Ver. MODULARIZADA ** \n")

// Diretório do script principal
caminho = get_absolute_file_path("met_newton-modular.sce")

// Carregamento das funções modularizadas
exec(caminho + "03_aval-poly.sce", -1)
exec(caminho + "04_plot-interp.sce", -1)
exec(caminho + "06_diff-divididas.sce", -1)
exec(caminho + "07_newton-poly.sce", -1)

// [1] ENTRADA DE DADOS

X = [-1, 0, 2]
Y = [4, 1, -1]

n = length(X)
printf("\n[1] TABELA DE DADOS:\n")
for i = 1:n
    printf("   x = %.6f; f(x) = %.6f\n", X(i), Y(i))
end

// [2] CALCULO DOS COEFICIENTES VIA DIFERENÇAS DIVIDIDAS

coef = diferencas_divididas(X, Y)
printf("\n[2] COEFICIENTES DAS DIFERENÇAS DIVIDIDAS:\n")
disp(coef)

// [3] CONSTRUÇÃO DO POLINOMIO DE NEWTON

PolNewton = newton_poly(X, coef)
printf("\n[3] POLINOMIO INTERPOLADOR POR NEWTON:\n")
disp(PolNewton)

// [4] AVALIAÇÃO DO POLINOMIO EM PONTOS ESPECIFICOS

// PONTOS DE INTERESSE (PODEM ADICIONAR N PONTOS)
pontos = [-0.5, 0.5]
valores_ref=[%nan, %nan]

for i = 1:length(pontos)
    ponto_i = pontos(i)
    valor_ref_i = valores_ref(i)

    if isnan(valor_ref_i) then
        [valor_aprox, erro_percentual] = avaliar_polinomio(PolNewton, ponto_i)
        printf("\n[4.%d] VALOR APROXIMADO: p(%.2f) = %.6f\n", i, ponto_i, valor_aprox)
        printf("[4.%d] ERRO PERCENTUAL: valor de referência não informado.\n", i)
    else
        [valor_aprox, erro_percentual] = avaliar_polinomio(PolNewton, ponto_i, valor_ref_i)
        printf("\n[4.%d] VALOR APROXIMADO: p(%.2f) = %.6f\n", i, ponto_i, valor_aprox)
        printf("[4.%d] ERRO PERCENTUAL: %.4f%%\n", i, erro_percentual)
    end
end

// [5] GRAFICO DO POLINOMIO INTERPOLADOR

plotar_interpolador(X, Y, PolNewton, pontos)

printf("\n***** FIM DE INTERPOLAÇÃO POR NEWTON *****\n")