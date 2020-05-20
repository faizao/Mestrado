
function [treinamento,classes,new_label_tr,label_best,pos_best] = analisar_parecidos(mascara,qtde_imgs_similares,conj)

% [mascara] = redimensionar(im_ocluida,conj.dim_reduced);
% 
% whos;
% treinamento = conj.treinamento_reduzido;
treinamento = conj.treinamento;
trainLabel = conj.trainLabel;

posicoes_nao_ocluidas = mascara>0;
pixels_nao_ocluidos = mascara(posicoes_nao_ocluidas);

vet_ssim= [];

for i =1: size(treinamento,2)
    aux = treinamento(:,i);
    aux = aux(posicoes_nao_ocluidas);
    ss = ssim(aux,pixels_nao_ocluidos);
    
    vet_ssim = [vet_ssim,ss];
end

[~,pos] = sort(vet_ssim,'descend');

[~,pos_best] = max(vet_ssim);
label_best = trainLabel(pos_best);


classes = [];


for i =1: qtde_imgs_similares
    classes = [classes,trainLabel(pos(i))];
end

classes = unique(classes);


[treinamento,new_label_tr] = reduzir_espaco_amostral(conj,classes,trainLabel);

end


function [new_treinamento,new_label] = reduzir_espaco_amostral(conj,classes,trainLabel)
treinamento = conj.treinamento;
numClass = conj.numClass;

intervalo = size(treinamento,2)/numClass;
new_treinamento = [];
new_label=[];
for i =1: length(classes)
    classe = classes(i);
    
    conj = treinamento(:, intervalo*classe - (intervalo-1):intervalo*classe);
    new_label= [new_label,trainLabel(intervalo*classe - (intervalo-1):intervalo*classe)];
    
    new_treinamento = [new_treinamento,conj];
end
end