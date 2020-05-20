clear;close; db= 1; origem = pwd;
cd('..\Funcoes_Extras');
[treinamento,teste] = leituraArquivo(1,'sem');
treinamento = treinamento(:,1:40); %Ver quantas pessoas por eigenspace iremos gerar
teste = teste(:,1:20);
cd(origem);
[treinamento,teste] = redimensionar_64(treinamento,teste);
nPixels = 256; %número de pixels a serem escolhidos
nAmostras = 1024; % número de amostras;

[E,imMedia] = calcPca(treinamento);%E = autovetores


[set_E,set_num_amostrados,set_amostras_pixels] = calc_low_Eig(treinamento,nPixels,nAmostras); %E, Xs

for i = 1: size(teste,2)
    
    imagem = teste(:,i);
    
    [erro_geral, erro_medio_amostra,erro_medio_geral] = reconstruirBloco(set_E,set_num_amostrados,imagem,set_amostras_pixels);
    
    reconstrucao(imMedia,erro_geral, erro_medio_amostra,erro_medio_geral, imagem,set_num_amostrados,E);
end


