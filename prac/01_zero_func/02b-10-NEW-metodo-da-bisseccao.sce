clear(); // LIMPA AS VARIAVEIS
clc() // LIMPA O CONSOLE

printf("*** APROXIMAÇÃO PELO MÉTODO DA BISSECÇÃO ***\n")

deff('y = f(x)', 'y = x^3-9*x+3') // DEF. DA FUNC. f(x)
ak = 0.0 // DEF. DO LIMITE INFERIOR DO INTERVALO
bk = 1.0 // DEF. DO LIMITE SUPERIOR DO INTERVALO

epsilon1 = 1e-06 // PRECISAO OU ERRO DESEJADO (PARA X)
epsilon2 = 1e-06 // PRECISAO OU ERRO DESEJADO (PARA Y)
k = 0 // CONTADOR DE ITERACOES
nMax = 100 // QUANTIDADE MAXIMA DE ITERACOES
xm = 0.5 * (ak + bk) // EXPRESSAO AS ITERACOES

printf(" k  |      xm    | abs(bk-ak) |    f(xm)   |      \n")

while (k < nMax) & (abs(bk - ak) > epsilon1) & (abs(f(xm)) > epsilon2)
    xm = 0.5 * (ak + bk)
    k = k + 1
    printf(" %2.2i | %10.6f | %10.6f | %10.6f |\n", k, xm, abs(bk-ak), f(xm))
    if f(ak) * f(xm) < 0 then
        bk = xm
    else
        ak = xm
    end
end

printf("Aprox. %8.6f a raiz, com %2.2i iteracoes", xm, k)
