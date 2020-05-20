function APCA()
clear;close all;clc;
[treinamento,teste,nomes] = leituraArquivo(2,'true');
% treinamento = treinamento(:,9:16);
% teste = teste(:,5:8);

[~,imMediaNO,~,A,B] = calcPca(treinamento); %Aplicando pca no conjunto de imagens não ocluídas

for i=1: size(teste,2)
    fprintf('Imagem: %i de: %i \n',i,size(teste,2));
    im = teste(:,i);
    
    [mascara, bin] = pegarMascara(im); %função para pegar a máscara da imagem
    
    bin = logical(bin);
    
    conj = treinamento; conj(bin,:) = 0;
    
%     conj = pegarMascara(conj);
    
    
    [~,imMediaOri,~,Aorig] = calcPca(conj); %Aplicando PCA no conjunto das imagens ocluídas
    
    fiNO = A*B;
    fiP = Aorig*B;
    
    
    fiNO = normalizar_EigenSpace(fiNO);
    fiP = normalizar_EigenSpace(fiP);
    
    reconstrucao_APCA(bin,im,imMediaNO,imMediaOri,fiP,fiNO,nomes{i});
%     pause();
    % pause(0.2);
    
end
end

function Fi = normalizar_EigenSpace(Fi)
for i = 1: size(Fi,2)
    Fi(:,i) = Fi(:,i)/norm(Fi(:,i)); % normalizando minhas eigenFaces
end
end

