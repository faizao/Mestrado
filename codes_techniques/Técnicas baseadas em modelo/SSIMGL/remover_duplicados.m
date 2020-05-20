function vet2 = remover_duplicados(vet)

vet2 = vet;
posicoes = [];


for i =1: size(vet,1)
   a = vet(i,1); b = vet(i,2);
%    whos;
   aux= sum(vet == [b a],2);
   pos = find(aux == 2);
   posicoes = [posicoes,pos];
   vet(i,:) = 0;
   
   
end

vet2(posicoes,:) = [];


end