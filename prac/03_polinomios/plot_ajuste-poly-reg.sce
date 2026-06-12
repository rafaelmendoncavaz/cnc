//=========================================
// Função: plotar_ajuste_polinomial (REGRESSÃO POLINOMIAL)
// Objetivo: gerar o gráfico do polinômio ajustado por mínimos quadrados aos
// pontos observados (X, Y)
//=========================================
// Entradas
//  X   : Vetor de abscissas dos dados observados
//  Y   : vetor de ordenadas por dados observados
// pol_ajuste : polinomio ajustado por minimos quadrados
//=========================================

function plotar_ajuste_polinomial(X, Y, Pol_ajuste)
    //=========================================
    // [1] Dominio refinado para a curva ajustada
    //=========================================
    dx = (max(X) - min(X)) * 0.05
    xx = linspace(min(X) - dx, max(X) + dx, 300)
    yy = horner(Pol_ajuste, xx)

    //=========================================
    // [2] Curva ajustada e dados observados
    //=========================================
    scf(0)  // Cria/seleciona a janela 0
    clf()   // Limpa tudo que havia nela

    plot2d(xx, yy, style = [color("blue")])
    h = gce()   // pega a curva recem plotada
    h.children.thickness = 4    // espessura da curva
    // Dados observados
    plot2d(X, Y, -4)

    //=========================================
    // [3] Titulo, eixos, legenda e grade
    //=========================================
    xtitle("Curva de Ajuste Polinomial - MQM", ...
        "Dados observados, X(i)", ...
        "Valores resultantes, Y(i)")
    legend(["Curva ajustada", "Dados observados"], 4)
    xgrid()

    //=========================================
    // [4] Ajustes visuais
    //=========================================
    ax = gca()
    ax.font_size = 4
    ax.x_label.font_size = 4
    ax.y_label.font_size = 4
    ax.title.font_size = 4

    lg = findobj("type", "Legend")
    
    if ~isempty(lg) then
        lg.font_size = 3
    end
endfunction
