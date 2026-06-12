// Função: Plotar interpolador
// Objetivo: Gerar o gráfico do polinômio interpolador ajustado aos pontos (X, Y)
//--------------------------------------------------------
// Entradas:
// X : Vetor de Abscissas dos pontos interpolados (xi)
// Y : Vetor de Ordenadas dos pontos interpolados (yi)
// COEF : Vetor de coeficientes do polinômio (do termo constante ao de maior grau)
//          Ou diretamente o polinômio simbólico (tipo poly)
// pontos_interp : Vetor de pontos nos quais o polinômio será destacado
//--------------------------------------------------------
// Observações:
// - A função detecta automaticamente se COEF já é um polinômio simbólico
// - O gráfico exibe os pontos originais (vermelhos), a curva ajustada (azul),
//      e os pontos destacados (quadrados vermelhos).
// - O título refelte a natureza da interpolação
//--------------------------------------------------------
function plotar_interpolador(X, Y, COEF, pontos_interp)
    // Se COEF já for um polinômio simbólico, extrai os coeficientes
    if typeof(COEF) == "polynomial" then
        COEF = coeff(COEF);
    end

    // Constrói o polinômio da forma simbólica a partir dos coeficientes
    Pol = poly(COEF, 'x', 'c');

    // Gera pontos para traçar a curva suavemente (com margem de 5%)
    x_min = min(X);
    x_max = max(X);
    delta = 0.05 * (x_max - x_min);
    xx = linspace(x_min - delta, x_max + delta, 300);
    yy = horner(Pol, xx);
    yy_interp = horner(Pol, pontos_interp);

    // Título e rótulos genéricos (ajustáveis)
    titulo = "Polinômio Interpolador p_n(x)";
    rotulo_x = "Valores tabulados: Vetor X";
    rotulo_y = "Valores tabulados: Vetor Y";

    // Geração do gráfico
    clf(); // Limpa o gráfico
    plot(X, Y, 'ro', xx, yy, 'b', pontos_interp, yy_interp, 'rs', 'LineWidth', 3.5);
    xgrid();

    // Título e Eixos
    xtitle(titulo, rotulo_x, rotulo_y);

    // Legenda - ordem precisa, respeitar a chamada ao 'plot'
    legend(["Dados", "p_n(x)", "Pontos Interpolados"], "in_lower_right");

    // Ajustes visuais (melhor legibilidade)
    a = gca();
    a.title.font_size = 4.5;
    a.x_label.font_size = 4.5;
    a.y_label.font_size = 4.5;
endfunction
//--------------------------------------------------------
