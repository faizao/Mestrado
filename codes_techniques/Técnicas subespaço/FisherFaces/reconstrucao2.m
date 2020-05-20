function reconstrucao2(imMedia,teste,U,nomes,pastaStorage)

[l,c] = size(teste);
dim = sqrt(l);
vet = repmat(imMedia,1,c);
imOcluidas = teste - vet;
w = U'*imOcluidas;
reconstrucao = U*w;

cd(pastaStorage);
for i =1 : size(reconstrucao,2)

    im = imMedia + reconstrucao(:,i);
    im = reshape(im,[dim dim]);
    
    aux = nomes{i};
    a = strsplit(aux,'.');
    a = cellstr(a(1));
    a = char(a(:));
    imwrite(uint8(im),strcat(a,'.png'));
    
end
end
