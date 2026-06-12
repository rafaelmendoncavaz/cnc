//plot de grafico

clear();clf() // limpa variaveis

printf("*********** Método da bissecção para encontrar raízes de funções ***********\n\n")
printf("*********** Exemplo com a função padrão ***********\n\n")

x = -4 : 0.1 : 4
y = x.^3 - 9*x + 3

plot2d(x,y)
h = gce()
line_handle = h.children
line_handle.thickness = 4
line_handle.line_mode = 1
line_handle.foreground = color('green')

xtitle("Localizacao das raizes: grafico de f(x) = x^3-9x+3",...
"Valores do dominio [-4, 4]", ...
"Valores da funcao f(x) = y")
a = gca()
a.title.font_size = 4
a.x_label.font_size = 4
a.y_label.font_size = 4

xgrid(1)
