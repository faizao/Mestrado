function eigenFaces()
% close;
[treinamento,teste,nomes] = leituraArquivo(2,'true');
teste = pegarMascara(teste);

[U,imMedia] = calcPca(treinamento);


[l,c] = size(teste);
dim = sqrt(l);
imOcluidas = teste - repmat(imMedia,1,c);
w = U'*imOcluidas;
reconstrucao = U*w;

for i =1 : size(reconstrucao,2)
%       im = U(:,i);
%       im = reshape(im,[128 128]);
%       imagesc(im+40);
%       colormap('gray');
%       title('imagem');
%       pause();
    im  = teste(:,i);
    imReconstruida = imMedia + reconstrucao(:,i);
    imReconstruida = reshape(imReconstruida,[dim dim]);
    vet= [im(:),imReconstruida(:)];
    verProjecao(vet);
%     pause();
    cd ('C:\Users\jonas\Desktop\conjuntos Yale\PCA');
    imR = uint8(imReconstruida);
    %imR = reshapeIm(imReconstruida);
    imwrite(imR,nomes{i});
    cd ..;



end

