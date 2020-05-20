function fisherFaces()

[treinamento,teste,nomes,qtde_classes] = leituraArquivo(2,'true');

teste = pegarMascara(teste);

labels = gerar_rotulos_linha(treinamento,qtde_classes);




[Upca,imMedia,k] = calcPca(treinamento);






Y = (treinamento - repmat(imMedia,1,size(treinamento,2)))'*Upca;

[W , mu_lda ] = lda (Y ,labels , k);

Utotal = Upca*W;

for i = 1: size(Utotal,2)
    Utotal(:,i) = Utotal(:,i)/norm(Utotal(:,i)); % normalizando minhas eigenFaces
end


% vet = [];
% for i =1:2: 10
%    im = Utotal(:,i);
%    im = reshape(im,[128 128]);
%    
%    im2 = Utotal(:,i+1);
%    im2 = reshape(im2,[128 128]);
%    
%    k = [im;im2];
%    vet = [vet,k];
%     
% end
% 
% imshow(vet,[]);
% 
% pause();



reconstrucao(imMedia,teste,Utotal,nomes); %k = Quantos melhores eu vou pegar para reconstruir


end


