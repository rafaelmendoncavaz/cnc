clear()
clc()

printf("\n********** INTERPOLAÇÃO POR SISTEMA DE EQUAÇÕES - VERSÃO MODULARIZADA **********\n\n")

// [0] Carregamento das Funções Modularizadas
// Gauss                    // Resolução do sistema linear por elim. de Gauss
// vander matrix            // Geração da matriz de Vandermonde
// avaliar_polinomio        // Avaliação do polinômio em um ponto
// plotar_interpolador      // Geração do gráfico com pontos e polinômio

// Diretório do script principal
caminho = get_absolute_file_path("a1-q2.sce")
// Carregamento das funções modularizadas
exec(caminho + "01_gauss.sce", -1)
exec(caminho + "02_matriz-vandermonde.sce", -1)
exec(caminho + "03_aval-poly.sce", -1)
exec(caminho + "04_plot-interp.sce", -1)
exec(caminho + "05_lagrange-poly.sce", -1)
exec(caminho + "06_diff-divididas.sce", -1)
exec(caminho + "07_newton-poly.sce", -1)

// [1] Entrada de Dados
X = [10, 20, 50, 100]
Y = [900, 450, 180, 90]

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
pontos=[30, 75]
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

printf("\n***** AJUSTE FUNCIONAL: Inverso / Direto / Linear *****\n")

//======================MENU DE MODELOS===================
printf("\n[1] ESCOLHA O MODELO A SER AJUSTADO:\n\n")
printf("   1 = Inversamente Proporcional:     T(x) = a / x\n")
printf("   2 = Inverso + Intercepto:          T(x) = a / x + b\n")
printf("   3 = Diretamente Proporcional:      T(x) = a * x\n")
printf("   4 = Linear (Afim):                 T(x) = a * x + b\n\n")

modo = input("Digite a  opção desejada (1 a 4): ")
printf("--------------------------------------------------\n")
//======================PONTOS A AVALIAR==================
// Pontos de Interesse = 30, 75
pontos = [30, 75]
//========================================================
// AJUSTES POR MINIMOS QUADRADOS
select modo
case 1 then
    //========================================================
    // [MODELO 1] T(x) = a / x, via MQM sem intercepto
    //========================================================
    Z = 1 ./ X
    a = sum(Z .* Y) / sum(Z.^2)
    Y_pred = a ./ X
    Y_pontos = a ./ pontos
    modelo_str = "T(x) = a / x"
    printf("[Modelo 1] Inversamente Proporcional: T(x) = %.3f / x\n", a)

case 2 then
    //========================================================
    // [MODELO 2] T(x) = a / x + b, via MQM com intercepto
    //========================================================
    Z = 1 ./ X
    A = [Z', ones(length(Z), 1)]
    coef = A \ Y'
    a = coef(1)
    b = coef(2)
    Y_pred = a ./ X + b
    Y_pontos = a ./ pontos + b
    modelo_str = "T(x) = a / x + b"
    printf("[Modelo 2] Inverso com Intercepto: T(x) = %.3f / x + %.3f\n", a, b)


case 3 then
    //========================================================
    // [MODELO 3] T(x) = a * x, via MQM Direcional sem intercepto
    //========================================================
    a = sum(X .* Y) / sum(X.^2)
    Y_pred = a .* X
    Y_pontos = a .* pontos
    modelo_str = "T(x) = a * x"
    printf("[Modelo 3] Diretamente Proporcional: T(x) = %.3f * x\n", a)

case 4 then
    //========================================================
    // [MODELO 4] T(x) = a * x + b, via MQM Linear com intercepto
    //========================================================
    A = [X', ones(length(X), 1)]
    coef = A \ Y'
    a = coef(1)
    b = coef(2)
    Y_pred = a .* X + b
    Y_pontos = a .* pontos + b
    modelo_str = "T(x) = a * x + b"
    printf("[Modelo 4] Linear(afim): T(x) = %.3f * x + %.3f\n", a, b)

else
    error("Opção inválida. Escolha novamente.")
end

//=================AVALIAÇÃO DE QUALIDADE=================
SS_tot = sum((Y - mean(Y)).^2)
SS_res = sum((Y - Y_pred).^2)
R2 = 1 - SS_res / SS_tot

printf("\n[Coeficiente de Determinação] R2 = %.6f\n", R2)
for i = 1:length(pontos)
    printf("[Predição %d] T(%.1f) = %.3f s\n", i, pontos(i), Y_pontos(i))
end
//================GERAÇÃO DE GRÁFICO======================
dx = (max(X) - min(X)) * 0.05
xx = linspace(min(X) - dx, max(X) + dx, 300)

select modo
case 1 then yy = a ./ xx
case 2 then yy = a ./ xx + b
case 3 then yy = a .* xx
case 4 then yy = a .* xx + b
end
//========================================================
// [GRÁFICO] Dados observados e curva ajustada
//========================================================
select modo
case 1 then
    estilo = "b-"   // Inversamente Proporcional
case 2 then
    estilo = "r-"   // Inverso com Intercepto
case 3 then
    estilo = "m-"   // Diretamente Proporcional
case 4 then
    estilo = "k-"   // Linear Afim
else
    estilo = "o-"
end

plot(xx, yy, estilo, "LineWidth", 4)
plot(X, Y, 'ko', "MarkerSize", 8, "MarkerFaceColor", "white")
plot(pontos, Y_pontos, 'bs', "MarkerSize", 8, "MarkerFaceColor", "black")
legendas = ["Dados observados"; modelo_str; "Pontos a avaliar"]
legend(legendas, "in_upper_right")
xtitle("Ajuste do modelo: " + modelo_str, "x", "T(x)")
xgrid()

ax = gca()
ax.font_size = 4
ax.x_label.font_size = 4
ax.y_label.font_size = 4
ax.title.font_size = 4

lg = findobj("type", "Legend")

if ~isempty(lg) then
    lg.font_size = 3
end
//========================================================
printf("\n***** FIM DO AJUSTE FUNCIONAL *****\n")
