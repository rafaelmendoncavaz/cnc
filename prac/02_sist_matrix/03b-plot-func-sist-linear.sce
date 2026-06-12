// SISTEMAS LINEARES 3X3: INTERPRETACAO GEOMETRICA COM PLANOS
clear();
clc();
clf();

// Define o intervalo para os 'x'
x1 = linspace(-5, 5, 200);
x2 = linspace(-5, 5, 200);

// Calcula y para cada equacao
y1 = -x1;		// equacao x + y = 0
y2 = 1 - x2;	// equacao x + y = 1

// y1 = -x1;		// equacao x + y = 0
// y2 = +x2;		// equacao 2x + 2y = 0

// y1 = -x1;		// equacao x + y = 0
// y2 = -x2;		// equacao 2x + 2y = 0

// Plota as linhas para as equacoes
plot(x1, y1, 'b');	// reta "azul" para primeira equacao
h1 = gce();			// obter o manipulador do objeto grafico
h1.children.thickness = 3;		// ajustar a espessura da linha
plot(x2, y2, 'r--');		// reta "vermelha" para para a segunda equacao

h2 = gce();
h2.children.thickness = 3;		// ajustar a espessura da linha

// Adiciona rotulos, legenda e grade
xlabel('Eixo X');
ylabel('Eixo Y');
legend(['x + y = 0', '2x + 2y = 0']);
xtitle('Graficos de x + y = 0 e 2x + 2y = 0');

a = gca();		// obter o manipulador dos eixos atuais
a.title.font_size = 4;		// ajustar o tamanho da fonte do titulo
a.x_label.font_size = 4;	// ajustar o tamanho da fonte do rotulo do eixo X
a.y_label.font_size = 4;	// ajustar o tamanho da fonte do rotulo do eixo Y
xgrid();
