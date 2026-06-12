//========================================================
// AJUSTES FUNCIONAIS BASICOS - Inversos, Diretos e Lineares
//========================================================
// Este script ajusta modelos funcionais simples:
//  [1] Inversamente proporcional   -> T(x) = a / x
//  [2] Inverso com intercepto      -> T(x) = a / x + b
//  [3] Diretamente proporcional    -> T(x) = a * x
//  [4] Linear (afim)               -> T(x) = a * x + b
//========================================================
//  Entrada de dados: vetores X e Y
// Ajuste por MQM direto ou transformado
//========================================================
printf("\n***** AJUSTE FUNCIONAL: Inverso / Direto / Linear *****\n")
//========================================================
//======================ENTRADA DE DADOS==================
// PROBLEMA Tempo x Velocidade
X = [10, 20, 50 , 100]
Y = [900, 450, 180, 90]
//========================================================
//======================MENU DE MODELOS===================
printf("\n[1] ESCOLHA O MODELO A SER AJUSTADO:\n")
printf("   1 = Inversamente Proporcional:     T(x) = a / x\n")
printf("   2 = Inverso + Intercepto:          T(x) = a / x + b\n")
printf("   3 = Diretamente Proporcional:      T(x) = a * x\n")
printf("   4 = Linear (Afim):                 T(x) = a * x + b\n")

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
    printf("[Modelo 1] T(x) = %.3f / x\n", a)

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
    printf("[Modelo 2] T(x) = %.3f / x + %.3f\n", a, b)


case 3 then
    //========================================================
    // [MODELO 3] T(x) = a * x, via MQM Direcional sem intercepto
    //========================================================
    a = sum(X .* Y) / sum(X.^2)
    Y_pred = a .* X
    Y_pontos = a .* pontos
    modelo_str = "T(x) = a * x"
    printf("[Modelo 3] T(x) = %.3f * x\n", a)

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
    printf("[Modelo 4] T(x) = %.3f * x + %.3f\n", a, b)

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
plot(X, Y, 'ro')
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

plot(xx, yy, estilo, "LineWidth", 3)
legendas = ["Dados"; modelo_str]
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