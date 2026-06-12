//INTERPOLAÇÃO POLINOMIAL POR SISTEMA LINEAR - Versão MODULARIZADA
clear ();

printf("\n**** INTERPOLAÇÃO POR MÉTODO DE LAGRANGE - VERSÃO MODULARIZADA ****\n\n")

// [0] Carregamento das Funções Modularizadas
// lagrange_poly            // Cálculo do polinômio de Lagrange
// avaliar_polinomio        // Avaliação do polinômio em um ponto
// plotar_interpolador      // Geração do gráfico com pontos e polinômio

// Diretório do script principal
caminho = get_absolute_file_path("met_lagrange-modular.sce")

// Carregamento das funções modularizadas
exec(caminho + "05_lagrange-poly.sce", -1)
exec(caminho + "03_aval-poly.sce", -1)
exec(caminho + "04_plot-interp.sce", -1)

// [1] ENTRADA DE DADOS

X = [10, 20, 50, 100]
Y = [900, 450, 180, 90]

n = length(X)
printf("\n[1] TABELA DE DADOS:\n")
for i = 1:n
    printf("   x = %.6f; f(x) = %.6f\n", X(i), Y(i))
end

// [2] CALCULO DE POLINOMIO DE LAGRANGE
[PolLagrange, BaseLagrange] = lagrange_poly(X, Y)

printf("\n[2] POLINOMIOS DE BASE DE LAGRANGE:\n")
for i = 1:n
    pol_str = pol2str(BaseLagrange(i))
    printf("   L_%d(x) = %s\n", i - 1, pol_str)
end

// [3] EXIBICAO DO POLINOMIO INTERPOLADOR

// PONTOS DE INTERESSE (PODEM ADICIONAR N PONTOS)
pontos = [30, 75]
valores_ref=[%nan, %nan]

printf("\n[3] POLINOMIO INTERPOLADOR POR LAGRANGE:\n")
disp(PolLagrange)

// [4] AVALIACAO DO POLINOMIO EM PONTOS ESPECIFICOS

for i = 1:length(pontos)
    ponto_i = pontos(i)
    valor_ref_i = valores_ref(i)

    if isnan(valor_ref_i) then
        [valor_aprox, erro_percentual] = avaliar_polinomio(PolLagrange, ponto_i)
        printf("\n[4.%d] VALOR APROXIMADO: p(%.2f) = %.6f\n", i, ponto_i, valor_aprox)
        printf("[4.%d] ERRO PERCENTUAL: valor de referência não informado.\n", i)
    else
        [valor_aprox, erro_percentual] = avaliar_polinomio(PolLagrange, ponto_i, valor_ref_i)
        printf("\n[5.%d] VALOR APROXIMADO: p(%.2f) = %.6f\n", i, ponto_i, valor_aprox)
        printf("[5.%d] ERRO PERCENTUAL: %.4f%%\n", i, erro_percentual)
    end
end

// [5] GRAFICO DO POLINOMIO INTERPOLADOR

plotar_interpolador(X, Y, PolLagrange, pontos)

printf("\n***** FIM DE INTERPOLAÇÃO POR LAGRANGE *****\n")