function [rotulo_tr,rotulo_ts] = gerar_rotulos(conj)
%Função: Gerar os rótulos para todos os conjuntos 
rotulo_tr = conjunto(conj.treinamento,conj.numClass);
rotulo_ts = conjunto(conj.teste,conj.numClass);



end

function rotulo = conjunto(conj,num_individuos) %mando gerar todos os rótulos
intervalo = size(conj,2)/num_individuos;
rotulo = [];
cont = 1;
for i=1:intervalo: size(conj,2)
    rotulo(i:i+intervalo-1)= cont;
    cont = cont+1;
    
    
end

end