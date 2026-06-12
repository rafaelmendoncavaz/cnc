clear()
clc()

printf("\n********** INTERPOLAÇÃO POR SISTEMA DE EQUAÇÕES - VERSÃO MODULARIZADA **********\n\n")

// [0] Carregamento das Funções Modularizadas
// Gauss                    // Resolução do sistema linear por elim. de Gauss
// vander matrix            // Geração da matriz de Vandermonde
// avaliar_polinomio        // Avaliação do polinômio em um ponto
// plotar_interpolador      // Geração do gráfico com pontos e polinômio

// Diretório do script principal
caminho = get_absolute_file_path("a1-q5.sce")
// Carregamento das funções modularizadas
exec(caminho + "01_gauss.sce", -1)
exec(caminho + "02_matriz-vandermonde.sce", -1)
exec(caminho + "03_aval-poly.sce", -1)
exec(caminho + "04_plot-interp.sce", -1)
exec(caminho + "05_lagrange-poly.sce", -1)
exec(caminho + "06_diff-divididas.sce", -1)
exec(caminho + "07_newton-poly.sce", -1)

// [1] Entrada de Dados
X = [1.0, 2.0, 2.5, 3.0]
Y = [45.0, 58.0, 66.5, 75.0]

n = length(X)           // Número de pontos 

printf("\n[1] TABELA DE DADOS:\n")
for i = 1:n
	printf("   x = %.6f; f(x) = %.6f\n", X(i), Y(i))
end

Vander = vander_matrix(X)

// [2] Montagem da matriz de Vandermonde
printf("\n[2] MATRIZ DE VANDERMONDE:\n")
disp(Vander)
COEF = Gauss(Vander, Y)

// [3] Resolução do Sistema Linear via Gauss
printf("\n[3] COEFICIENTES DO POLINÔMIO:\n")
coef_labels = ['a0', 'a1', 'a2', 'a3', 'a4', 'a5']
for i = 1:n
	mprintf("   %s = %.6f\n", coef_labels(i), COEF(i))
end

Pol = poly(COEF, 'x', 'c')

// [4] Construção do Polinômio Interpolador
printf("\n[4] POLINÔMIO INTERPOLADOR:\n")
disp(Pol)


// [5] Avaliação do Polinômio em um Ponto Específico
// PONTOS DE INTERESSE (PODEM ADICIONAR N PONTOS)
pontos=[1.8, 2.7]
valores_ref=[%nan, %nan]

// Avaliação ponto a ponto + funções de erro

for i = 1 : length(pontos)
	ponto_i = pontos(i);
	valores_ref_i = valores_ref(i)

	if isnan(valores_ref_i) then
		[valor_aprox, erro_percentual] = avaliar_polinomio(Pol, ponto_i)
		printf("\n[5.%d] VALOR APROXIMADO: p_n(%.2f) = %.6f\n", i, ponto_i, valor_aprox)
		printf("\n[5.%d] ERRO PERCENTUAL: Valor de referência não informado\n", i)
	else 
		[valor_aprox, erro_percentual] = avaliar_polinomio(Pol, ponto_i, valores_ref_i)
		printf("\n[5.%d] VALOR APROXIMADO: p_n(%.2f) = %.6f\n", i, ponto_i, valor_aprox)
		printf("\n[5.%d] ERRO PERCENTUAL: %.4f%%\n", erro_percentual)
	end
end

// [6] Plotar interpolador
plotar_interpolador(X, Y, COEF, pontos)
printf("\n***** FIM DE INTERPOLAÇÃO POR SISTEMA DE EQUAÇÕES *****\n")

printf("\n**** INTERPOLAÇÃO POR MÉTODO DE LAGRANGE - VERSÃO MODULARIZADA ****\n\n")

// [2] CALCULO DE POLINOMIO DE LAGRANGE
[PolLagrange, BaseLagrange] = lagrange_poly(X, Y)

printf("\n[2] POLINOMIOS DE BASE DE LAGRANGE:\n")
for i = 1:n
    pol_str = pol2str(BaseLagrange(i))
    printf("   L_%d(x) = %s\n", i - 1, pol_str)
end

// [3] EXIBICAO DO POLINOMIO INTERPOLADOR

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

printf("\n** INTERPOLAÇÃO PELO MÉTODO DE NEWTON - Ver. MODULARIZADA ** \n")

// [2] CALCULO DOS COEFICIENTES VIA DIFERENÇAS DIVIDIDAS

coef = diferencas_divididas(X, Y)
printf("\n[2] COEFICIENTES DAS DIFERENÇAS DIVIDIDAS:\n")
disp(coef)

// [3] CONSTRUÇÃO DO POLINOMIO DE NEWTON

PolNewton = newton_poly(X, coef)
printf("\n[3] POLINOMIO INTERPOLADOR POR NEWTON:\n")
disp(PolNewton)

// [4] AVALIAÇÃO DO POLINOMIO EM PONTOS ESPECIFICOS

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
