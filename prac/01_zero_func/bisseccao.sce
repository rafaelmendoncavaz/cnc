//Mét. Bissecção para encontrar raízes de funções

clear(); clc() // limpa variaveis

printf("*********** Aproximação de raízes de funções usando o método da bissecção ***********\n\n")
printf("*********** Exemplo com a função padrão ***********\n\n")

deff('y = f(x)', 'y = x^3 - 9*x + 3')
ak = 0.0
bk = 1.0

epsilon1 = 1e-6
epsilon2 = 1e-6
k = 0
nmax = 100
xm = 0.5 * (ak + bk)

printf("  k  |  xm  |  abs(bk - ak)  |  f(xm)  \n")
 while (k < nmax) & (abs(bk - ak) > epsilon1) & (abs(f(xm)) > epsilon2) 
  xm = 0.5 * (ak + bk)
  k = k + 1
printf(" %2i | %10.6f | %10.6f | %10.6f \n", k, xm, abs(bk - ak), f(xm))
  if (f(ak) * f(xm) < 0) then
    bk = xm
  else
    ak = xm
  end
end

printf("\nRaiz aproximada: %10.6f\n", xm)
printf("Numero de iteracoes: %i\n", k)

