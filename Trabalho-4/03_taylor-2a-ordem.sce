//==================================================================
// METODO DE TAYLOR DE 2ª ORDEM PARA PVI: y' = f(x, y), y(0) = y0
//==================================================================
function [x, y] = taylor_2a_ordem(f, df, x0, y0, h, n)
	x = zeros(1, n + 1)
	y = zeros(1, n + 1)
	
	x(1) = x0
	y(1) = y0

	for i = 1:n
		x(i + 1) = x(i) + h
		y(i + 1) = y(i) + h * f(x(i), y(i)) + 0.5 * h^2 * df(x(i), y(i))
	end
endfunction
