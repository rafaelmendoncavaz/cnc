//Mét. de Secante para encontrar raízes de funções

clear();    // limpa variaveis

printf("*********** Aproximação de raízes de funções usando o método de Secante ***********\n\n")
printf("*********** Exemplo com a função padrão ***********\n\n")

deff('y = f(x)', 'y = x^3 - 9*x + 3')

x_anterior0 = 0.0
x_anterior1 = 1.0

epsilon1 = 1e-6
epsilon2 = 1e-6
k = 0
nmax = 100

x_atual = x_anterior1 - (f(x_anterior1) * (x_anterior1 - x_anterior0) / (f(x_anterior1) - f(x_anterior0))) 

printf("  k  |  Xk  |  abs(Xk - Xk-1)  |  f(Xk)  \n")
 while (k < nmax) & (abs(x_atual - x_anterior) > epsilon1) & (abs(f(x_anterior)) > epsilon2) 
  x_anterior0 = x_anterior1
  x_anterior1 = x_atual
  x_atual = x_anterior1 - (f(x_anterior1) * (x_anterior1 - x_anterior0) / (f(x_anterior1) - f(x_anterior0))) 
  k = k + 1
printf(" %2i | %10.6f | %10.6f | %10.6f \n", k, x_anterior1, abs(x_anterior1 - x_anterior0), f(x_anterior0))

  end

printf("\nRaiz aproximada: %10.6f\n", x_atual)
printf("Numero de iteracoes: %i\n", k)

