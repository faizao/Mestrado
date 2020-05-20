function fisherFaces2(treinamento,teste,nomes,pastaStorage,variancia,qtde_classes)

teste = pegarMascara(teste);

labels = gerar_rotulos_linha(treinamento,qtde_classes);


[Upca,imMedia,k] = calcPca(treinamento,variancia);

Y = (treinamento - repmat(imMedia,1,size(treinamento,2)))'*Upca;

[W , mu_lada ] = lda2 (Y ,labels , k);

Utotal = Upca*W;

for i = 1: size(Utotal,2)
    Utotal(:,i) = Utotal(:,i)/norm(Utotal(:,i)); % normalizando minhas eigenFaces
end

reconstrucao2(imMedia,teste,Utotal,nomes,pastaStorage); %k = Quantos melhores eu vou pegar para reconstruir

end


