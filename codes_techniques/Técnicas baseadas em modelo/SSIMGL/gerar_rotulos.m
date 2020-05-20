function [rotulo_tr,rotulo_ts] = gerar_rotulos(conj)
treinamento = conj.treinamento;
teste = conj.teste;
numClass = conj.numClass;
%Função: Gerar os rótulos para todos os conjuntos 
rotulo_tr = conjunto(treinamento,numClass);
rotulo_ts = conjunto(teste,numClass);



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