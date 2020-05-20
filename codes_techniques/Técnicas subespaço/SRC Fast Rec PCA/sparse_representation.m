function  vetor = sparse_representation(Y, A,treinamento,teste,label_tr,mascara)
fprintf('\n Aplicando representacao Esparsa');
sc_algo= 'l1magic'; % Compute the sparse representation X

Ainv = pinv(A);
im1 = teste(:,1);
xInit = Ainv * Y(:,1);
% sparse coding: solve a linear system
xp = sparse_coding_methods(xInit, A, Y(:,1), sc_algo);
[~, posicoes ]= sort(xp,'descend');
% label_ts = testLabel(it); %rotulo do teste

qtde_classes = max(label_tr);

rotulos = label_tr(posicoes(1:20)); %Pego as 20 melhores posições

[C,ac,ic] = unique(rotulos);
a_counts = accumarray(ic,1)';
% whos;
value_counts = [C, a_counts];
[~,b] = max(value_counts(:,2));

classe_plus_repeat = value_counts(1,b); %pegando o cara que mais se repetiu dentre os 20


plus_src = rotulos(1); %pegando o cara que a SRC deu mais parecido
rotulos = unique(rotulos); % deixo todos os rótulos

pixels_borda = realizar_processamento_mask(mascara);


tr = colocar_individuos_por_celula(treinamento,qtde_classes);

dist = 0;

for i =1: length(rotulos) % vou em cada cara dos 20 que deu
    conjunto = tr{rotulos(i)};
    
    
%     distancias = calc_knn_src(im1(pixels_borda),conjunto(pixels_borda,:));
    similaridades = calc_ssim_src(im1(pixels_borda),conjunto(pixels_borda,:));
    
    [valor,pose] = max(similaridades);
    
    if valor > dist
        dist = valor;
        individuo = rotulos(i); %pego o indivíduo
        variacao = pose; % pego sua respectiva pose
    end

end

aux = [individuo,classe_plus_repeat,plus_src];
aux = unique(aux);

vetor = [];
for m =1: length(aux)
    vetor = [vetor,tr{aux(m)}];
    
end

end


% function distancias = calc_knn_src(ts,tr)
% distancias = [];
% 
% for i = 1: size(tr,2)
%     d = sqrt(sum((ts - tr(:,i)).^2));
%     distancias = [distancias,d];
% end
% end

function ssims = calc_ssim_src(ts,tr)
ssims = [];

for i = 1: size(tr,2)
    d = ssim(tr(:,i),ts);
    ssims = [ssims,d];
end
end



function aux = realizar_processamento_mask(mascara)
mascara = reshape(mascara,[128 128]);

aux = mascara;
mascara = bwmorph(mascara,'erode');
mascara = bwmorph(mascara,'erode');
mascara = bwmorph(mascara,'erode');
mascara = bwmorph(mascara,'erode');
mascara = bwmorph(mascara,'erode');
mascara = bwmorph(mascara,'erode');
mascara = bwmorph(mascara,'erode');
mascara = bwmorph(mascara,'erode');

aux = mascara - aux;
aux = abs(aux);
aux = find(aux);

end