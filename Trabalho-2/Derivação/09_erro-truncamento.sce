//==================================================================
// Função: Erro_Truncamento_P
function Erro_Truncamento_P(h, derivada_2a_exata)
    erro_trunc = abs(- (h / 2) * derivada_2a_exata)
    printf(" Erro de truncamento (progressiva 1a ordem): | -(h / 2) * segunda derivada | %.6f\n", erro_trunc)
endfunction
//==================================================================
// Função: Erro_Truncamento_R
function Erro_Truncamento_R(h, derivada_2a_exata)
    erro_trunc = abs((h / 2) * derivada_2a_exata)
    printf(" Erro de truncamento (regressiva 1a ordem): | (h / 2) * segunda derivada | %.6f\n", erro_trunc)
endfunction
//==================================================================
// Função: Erro_Truncamento_C21
function Erro_Truncamento_C21(h, derivada_3a_exata)
    erro_trunc = abs((h^2 / 6) * derivada_3a_exata)
    printf(" Erro de truncamento (centrada 2a ordem 1a derivada): | (h^2 / 6) * terceira derivada | %.6f\n", erro_trunc)
endfunction
//==================================================================
// Função: Erro_Truncamento_C22
function Erro_Truncamento_C22(h_prod, derivada_4a_exata)
    erro_trunc = abs(-(h_prod / 12) * derivada_4a_exata)
    printf(" Erro de truncamento (centrada 2a ordem 2a derivada): | (h / 12) * quarta derivada | %.6f\n", erro_trunc)
endfunction
//==================================================================
