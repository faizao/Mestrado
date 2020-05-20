function [treinamento] = reduzir_numero_Amostras(conj)

treinamento = alterar_tamanho(conj.treinamento,conj.numClass);



end


function new_conj = alterar_tamanho(conjunto,numClass)
[l,c] = size(conjunto);
intervalo = c/numClass;
dim = sqrt(l);
new_conj = [];
for i = 1:intervalo :size(conjunto,2)
    
    im1 = conjunto(:,i); %só pego uma amostra de cada conjunto, umas das mais representativas
    im2 = conjunto(:,i+1);
    new_conj = [new_conj,im1,im2];
end




end