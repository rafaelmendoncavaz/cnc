//INTERPOLAÇÃO POLINOMIAL POR SISTEMA LINEAR - Versão MODULARIZADA
clear ();

printf("\n********** INTERPOLAÇÃO POR SISTEMA DE EQUAÇÕES - VERSÃO MODULARIZADA **********\n\n")

// [0] Carregamento das Funções Modularizadas
// Gauss                    // Resolução do sistema linear por elim. de Gauss
// vander matrix            // Geração da matriz de Vandermonde
// avaliar_polinomio        // Avaliação do polinômio em um ponto
// plotar_interpolador      // Geração do gráfico com pontos e polinômio

// Diretório do script principal
caminho = get_absolute_file_path("met_linear-sist-interp-modular.sce")
// Carregamento das funções modularizadas
exec(caminho + "01_gauss.sce", -1)
exec(caminho + "02_matriz-vandermonde.sce", -1)
exec(caminho + "03_aval-poly.sce", -1)
exec(caminho + "04_plot-interp.sce", -1)

// [1] Entrada de Dados
X = [0, 1, 2, 3, 4, 5, 6]
Y = [5.04, 5.93, 12.08, 26.01, 44.91, 70.21, 100.87]

n = length(X)           // Número de pontos 

printf("\n[1] TABELA DE DADOS:\n")
for i = 1:n
	printf("   x = %.6f; f(x) = %.6f\n", X(i), Y(i))
end

// [2] Montagem da matriz de Vandermonde
Vander = vander_matrix(X)

printf("\n[2] MATRIZ DE VANDERMONDE:\n")
disp(Vander)

// [3] Resolução do Sistema Linear via Gauss
COEF = Gauss(Vander, Y)
printf("\n[3] COEFICIENTES DO POLINÔMIO:\n")
coef_labels = ['g', 'f', 'e', 'd', 'c', 'b', 'a']
for i = 1:n
	mprintf("   %s = %.6f\n", coef_labels(i), COEF(i))
end

// [4] Construção do Polinômio Interpolador
Pol = poly(COEF, 'x', 'c')
printf("\n[4] POLINÔMIO INTERPOLADOR DE VANDERMONDE:\n")

coef = coeff(Pol)
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

// [5] Avaliação do Polinômio em um Ponto Específico
// PONTOS DE INTERESSE (PODEM ADICIONAR N PONTOS)
pontos=[0.5]
valores_ref=[%nan]

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

// [6] PLotar interpolador
plotar_interpolador(X, Y, COEF, pontos)
printf("\n***** FIM DE INTERPOLAÇÃO POR SISTEMA DE EQUAÇÕES *****\n")
