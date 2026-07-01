//==================================================================
// GERAR GRAFICO DIDATICO PARA SOLUÇÕES APROXIMADAS DE UM PVI
//==================================================================
function plotar_resultado_aproximado(X, Y, pontos_destacados, titulo, rotulo_x, rotulo_y)
	// Geração de uma curva suave para visualização
	x_min = min(X)
	x_max = max(X)

	delta = 0.05 * (x_max - x_min)

	xx = linspace(x_min - delta, x_max + delta, 300)
	yy = interp1(X, Y, xx, "linear") // visualização continua

	// Avaliação dos pontos destacados (se fornecidos)
	if argn(2) >= 3 & ~isempty(pontos_destacados) then
		yy_dest = interp1(X, Y, pontos_destacados, "linear")
		destacar = %T
	else
		destacar = %F
	end

	// Geração do gráfico
	clf()
	if destacar then
		plot(X, Y, 'ro', xx, yy, 'b', pontos_destacados, yy_dest, 'rs', 'LineWidth', 3.5)
		legend(["Aproximações", "Visualização Contínua", "Pontos Destacados"], "in_upper_left")
	else
		plot(X, Y, 'ro', xx, yy, 'b', 'LineWidth', 3.5)
		legend(["Aproximações", "Visualização Contínua"], "in_upper_left")
	end

	// Títulos e Rótulos
	xtitle(titulo, rotulo_x, rotulo_y)

	// Estética e Legibilidade
	xgrid(1)
	a = gca()
	a.title.font_size = 4.5
	a.x_label.font_size = 4.5
	a.y_label.font_size = 4.5
endfunction
