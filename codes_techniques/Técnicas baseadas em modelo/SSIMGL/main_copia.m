clear;close;clc;

cd (pwd);

addpath(genpath(pwd));

AR_rep = loadBasesRepresentativas();

conj.dim_reduced = 32;
qtde_imgs_similares  = 10;
[conj.treinamento,conj.teste,conj.nomes,conj.numClass] = leituraArquivo(2,'true');
conj.treinamento_reduzido = redimensionar(conj.treinamento,conj.dim_reduced);

% conj.treinamento = redimensionar(conj.treinamento,32);
% conj.teste = redimensionar(conj.teste,32);

[conj.trainLabel,conj.testLabel] = gerar_rotulos(conj);%Gerando rótulos

Lfull = load('Lfull.mat');
Lfull = Lfull.Lfull_128;

intervalo = size(conj.teste,2)/conj.numClass;


cont_intervalo = 1;
ponteiro_AR_rep = 1;


for i =1: size(conj.teste,2)
    im_rep = AR_rep(:,ponteiro_AR_rep); %pegando a imagem representativa do cara
    
    im_ocluida = conj.teste(:,i);
    [mascara, mask_bin] = pegarMascara(im_ocluida);
    

    
    disp('================================');
    
    tic;
    [treinamento_reduced,classes_reduced,new_label_tr,label_best,pos_best]= analisar_parecidos(mascara,qtde_imgs_similares,conj);
    toc;
    
    imagemRec = gerar_grafo(Lfull,conj.treinamento(:,pos_best),mascara,mask_bin);
    
    cd ('C:\Users\jonas\Desktop\conjuntos Yale\SSIMGL');
    im = reshapeIm(imagemRec);
    imwrite(im,conj.nomes{i});
    
    cd ..;
%     list_images = passar_matriz_retornar_imgs([im_ocluida,mascara, imagemRec]);
%     imshow(list_images);
%     verProjecao([im_ocluida,mascara, imagemRec]);
%     
%     fprintf('imagem: %i de %i \n',i,size(conj.teste,2));
    
%     im_ocluida = conj.teste(:,i); %trocando ela pela imagem de dimensão original
%     frpca = FastRecPCA(treinamento_reduced,im_ocluida);%(tre,teste,nome,destRec,pasta)
%     ssim1 = ssim(im_rep,frpca);
    
%     classes_reduced
    
%     cd('Reconstrucoes');
%     imwrite(list_images,strcat('reconstrucao_',num2str(i),'.png'));
%     
%     cd ..;
    
    
%     labels_bests_SRC
%     frpca2 =FastRecPCA(conj.treinamento,im_ocluida);%(tre,teste,nome,destRec,pasta)
%     ssim2 = ssim(im_rep,frpca2);
    %
    %     [gpca,gpca2] = GPCA(treinamento_reduced,im_ocluida);
    %     ssim2 = ssim(im_rep,gpca);
    %     ssim3 = ssim(im_rep,gpca2);
    %
    %
    %     texto = strcat(num2str(ssim1),'|',num2str(ssim2),'|',num2str(ssim3));
%      texto = strcat(num2str(ssim1),'|',num2str(ssim2));
%     verProjecao([im_ocluida,im_rep, frpca]);%,texto);
    
%     cd(strcat(origem,'/Reconstrucoes'));
%     
%     imwrite(reshapeIm(frpca),conj.nomes{i});
    
    
    
%     pause(0.2);
%     
%     if cont_intervalo == intervalo
%         cont_intervalo = 0;
%         ponteiro_AR_rep = ponteiro_AR_rep + 1;
%     end
%     
%     cont_intervalo = cont_intervalo+1;
    
end


%     classes_reduced

%     labels_bests_SRC = sparse_representation(testLabel(i),im_ocluida, treinamento_reduced,new_label_tr,mascara);%resolvendo codificação Esparsa

%     classes_reduced
%     label_best
%     labels_gerais = [label_best,labels_bests_SRC(1:3)]
%
%     labels = unique(labels_gerais)

%     pos_presentes = find(classes_reduced == ponteiro_AR_rep);
%
%     if length(pos_presentes) == 0
%         erros = erros+1;
%     end
%
%
%     %     verProjecao(im_ocluida,strcat('ind: ',num2str(ponteiro_AR_rep)));
%
%     %disp(classes_reduced(1));
%
%     %     pause(0.2);
%     %
%     %
%     %



