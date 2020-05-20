function APCA2(treinamento,teste,nomes,destRec,pastaStorage)

origem = pwd;
cd (origem);

[imNO, ~] = pegarMascara(teste); %função para pegar a máscara da imagem
imNO = [treinamento,imNO]; %juntando o treinamento com as imgs não ocluídas do teste

imsOcluidasTeste = teste;
teste = [treinamento, teste];
[B,imMediaNO,A] = pca(imNO); %Aplicando pca no conjunto de imagens não ocluídas
[~,imMediaOri,Aorig] = pca(teste); %Aplicando PCA no conjunto das imagens ocluídas

fiNO = A*B;
fiP = Aorig*B;

fiNO = normalizar_EigenSpace(fiNO);
fiP = normalizar_EigenSpace(fiP);

reconstrucao_APCA(imsOcluidasTeste,imMediaNO,imMediaOri,fiP,fiNO,nomes,destRec,pastaStorage);

end

function Fi = normalizar_EigenSpace(Fi)
for i = 1: size(Fi,2)
    Fi(:,i) = Fi(:,i)/norm(Fi(:,i)); % normalizando minhas eigenFaces
end
end

