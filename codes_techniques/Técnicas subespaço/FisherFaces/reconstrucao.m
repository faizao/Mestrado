
function reconstrucao(imMedia,teste,U,nomes)
%U = U(:,1:m);
[l,c] = size(teste);
dim = sqrt(l);
vet = repmat(imMedia,1,c);

imOcluidas = teste - vet;
w = U'*imOcluidas;
reconstrucao = U*w;

% cd(pastaStorage);
for i =1 : size(reconstrucao,2)
%     i
    im  = teste(:,i);
    imR = imMedia + reconstrucao(:,i);
    aux = [im,imR];
    verProjecao(aux,strcat('imagem: ',num2str(i)));
    cd ('C:\Users\jonas\Desktop\conjuntos Yale\Fisherfaces');
    imwrite(reshapeIm(imR),nomes{i});
    cd ..;
%     pause();
%     imwrite(uint8(imReconstruida),strcat(a,'.png'));
    
%     im = reshape(im,[dim dim]);
%     rec = [rec,imReconstruida(:)];
%     a = [im,imReconstruida];
%     a = uint8(a);
%     imshow(a);
%     pause(0.4);
 %   imwrite(a,strcat(int2str(i),'.png'));
end

%save('recYale.mat','rec');


end
