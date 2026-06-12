clear(); // LIMPA AS VARIAVEIS
clc(); // LIMPA O CONSOLE
clf(); // LIMPA A SAIDA GRAFICA

printf("\***** nMETODO GRAFICO PARA ISOLAR AS RAIZES DA FUNC ***** \n");
printf("\n ********** EXEMPLO COM A FUNC PADRAO ******************\n");

x = -4:0.1:4 // DOMINIO DA FUNC (DE -4 A 4 EM INTERVALOS DE 0.1)
y = x.^3-9*x+3 // O PONTO INDICA O VETOR

plot2d(x, y)
h = gce() // OBTER O MANIPULADOR DO OBJETO GRAFICO ATUAL (A LINHA PLOTADA)
line_handle = h.children // h.children EH O MANIPULADOR DA LINHA
line_handle.thickness = 4 // AJUSTAR A ESPESSURA DA LINHA
line_handle.line_mode = 1 // HABILITAR A MODIF. DE PROPRIEDADES DA LINHA
line_handle.foreground = color('blue') // ESPECIFICAR A COR DA LINHA

xtitle("Localização das raizes: gráfico de f(x) = x³-9x+3",...
"Valores do domínio [-4, 4]",...
"Valores da função f(x) = y")

a = gca() // OBTER O MANIPULADOR DOS EIXOS ATUAIS
a.title.font_size = 4 // AJUSTAR O TAMANHO DA FONTE DO TÍTULO
a.x_label.font_size = 4 // AJUSTAR O TAMANHO DA FONTE DO RÓTULO DO EIXO X
a.y_label.font_size = 4 // AJUSTAR O TAMANHO DA FONTE DO RÓTULO DO EIXO Y

xgrid()
