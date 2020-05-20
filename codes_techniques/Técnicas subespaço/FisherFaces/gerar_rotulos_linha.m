function rotulos = gerar_rotulos_linha(conjunto,qtde_individuos)
[~,col] = size(conjunto);
intervalo = col/qtde_individuos;

cont = 1;
rotulo = 1;
rotulos = [];
for i =1: col
    rotulos = [rotulos,rotulo];
    if cont == intervalo
       rotulo = rotulo + 1;
       cont = 0; 
    end
    
    
    
    cont = cont + 1;
    
    
    
end
rotulos = rotulos';



end