//==================================================================
// METODO DE RUNGE-KUTTA DE 4ª ORDEM PARA PVI: y' = f(x, y)
//==================================================================
function [x, y] = rk_4a_ordem(f, x0, y0, h, n)
	x = zeros(1, n + 1)
	y = zeros(1, n + 1)

	x(1) = x0
	y(1) = y0

	for i = 1:n
		xi = x(i)
		yi = y(i)

		k1 = h * f(xi, yi)
		k2 = h * f(xi + 0.5 * h, yi + 0.5 * k1)
		k3 = h * f(xi + 0.5 * h, yi + 0.5 * k2)
		k4 = h * f(xi + h, yi + k3)

		x(i + 1) = x(i) + h
		y(i + 1) = y(i) + (1/6) * (k1 + 2 * k2 + 2 * k3 + k4)
	end
endfunction
