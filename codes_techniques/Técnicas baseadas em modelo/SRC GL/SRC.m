function SRC()
addpath(pwd);
addpath(genpath('C:\Users\jonas\Google Drive\libs\Grafos'));
%dim = 64;
[conj.treinamento,conj.teste,conj.nomes,conj.numClass] = leituraArquivo(2,'true');
%[conj.treinamento,conj.teste] = resize_conjunto(conj,dim);%redimensionando para (dim x dim) default (64,64);
%%
[trainLabel,testLabel] = gerar_rotulos(conj);%Gerando rótulos
[mascara, mask] = pegarMascara(conj.teste);
qtde_imagens = size(mascara,2);
%%
Lfull = get_grafo('laplace');

for i =1: qtde_imagens
%     [~,last_name] = fileparts(pwd);
    fprintf('\n imagem: %i',i);
%      fprintf('\n imagem: %i |  Base: %s',i,last_name);
    
    [new_tr,new_ts] = gerar_treinamento_oclusao(mascara(:,i),conj.treinamento); %crio um novo treinamento, só envolvendo os pixels não ocluídos

    [GU,GL] = sparse_representation(i,testLabel,new_ts, new_tr,conj.treinamento,conj.teste(:,i),trainLabel,mask(:,i));%resolvendo codificação Esparsa

    imagemRec= gerar_grafo(Lfull,GL,GU,mask(:,i));
    
    cd ('C:\Users\jonas\Desktop\conjuntos Yale\SRC_GL');
    imwrite(reshapeIm(imagemRec),conj.nomes{i});
    cd ..;

    
end
end

