//INTERPOLAÇÃO POLINOMIAL POR SISTEMA LINEAR - Versão MODULARIZADA
clear ();

printf("\n********** INTERPOLAÇÃO POR SISTEMA DE EQUAÇÕES - VERSÃO MODULARIZADA **********\n\n")

// [0] Carregamento das Funções Modularizadas
// Gauss                    // Resolução do sistema linear por elim. de Gauss
// vander matrix            // Geração da matriz de Vandermonde
// avaliar_polinomio        // Avaliação do polinômio em um ponto
// plotar_interpolador      // Geração do gráfico com pontos e polinômio

// Diretório do script principal
caminho = get_absolute_file_path("problema-1.sce")
// Carregamento das funções modularizadas
exec(caminho + "01_gauss.sce", -1)
exec(caminho + "02_matriz-vandermonde.sce", -1)
exec(caminho + "03_aval-poly.sce", -1)

// [1] Entrada de Dados
X = [0, 1, 2, 3, 4, 5]
Y = [0.01, 0.69, 1.09, 1.40, 1.60, 1.79]

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

printf("\n***** FIM DE INTERPOLAÇÃO POR SISTEMA DE EQUAÇÕES *****\n")
