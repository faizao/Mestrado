function FRPCA()
[treinamento,teste,nomes] = leituraArquivo(2,'true');
[treinamento,teste] = redimensionar_64(treinamento,teste);
nPixels = 2048; %número de pixels a serem escolhidos
nAmostras = 256; % número de amostras;

[E,imMedia] = calcPca(treinamento);%E = autovetores

[set_E,set_num_amostrados,set_amostras_pixels] = calc_low_Eig(treinamento,nPixels,nAmostras); %E, Xs

for i = 1: size(teste,2)
    
    imagem = teste(:,i);
    
    [erro_geral, erro_medio_amostra,erro_medio_geral] = reconstruirBloco(set_E,set_num_amostrados,imagem,set_amostras_pixels);
    
    reconstrucao(imMedia,erro_geral, erro_medio_amostra,erro_medio_geral, imagem,set_num_amostrados,E,nomes{i});
  
end
end

