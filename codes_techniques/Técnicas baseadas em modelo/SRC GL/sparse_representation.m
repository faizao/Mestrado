function  [im1,im2] = sparse_representation(it,testLabel,Y, A,treinamento,teste,label_tr,mascara)
fprintf('\n Aplicando representacao Esparsa');
sc_algo= 'l1magic'; % Compute the sparse representation X

Ainv = pinv(A);
im1 = teste(:,1);
xInit = Ainv * Y(:,1);
% sparse coding: solve a linear system
xp = sparse_coding_methods(xInit, A, Y(:,1), sc_algo);
[~, posicoes ]= sort(xp,'descend');
label_ts = testLabel(it); %rotulo do teste

qtde_classes = max(label_tr);

rotulos = label_tr(posicoes(1:20)); %Pego as 20 melhores posições
rotulos = unique(rotulos); % deixo todos os rótulos

pixels_borda = realizar_processamento_mask(mascara);


tr = colocar_individuos_por_celula(treinamento,qtde_classes);

dist = inf;

for i =1: length(rotulos)
    conjunto = tr{rotulos(i)};
    
    
    distancias = calc_knn_src(im1(pixels_borda),conjunto(pixels_borda,:));
    [valor,pose] = min(distancias);
    
    if valor < dist
        dist = valor;
        individuo = rotulos(i); %pego o indivíduo
        variacao = pose; % pego sua respectiva pose
    end

end

individuos = tr{individuo};
im2 = individuos(:,variacao);
% [~,posicao]= max(xp);
% im2 = treinamento(:,posicao);

% verProjecao([im1,im2]);
% pause();
end


function distancias = calc_knn_src(ts,tr)
distancias = [];

for i = 1: size(tr,2)
    d = sqrt(sum((ts - tr(:,i)).^2));
    distancias = [distancias,d];
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

aux = mascara - aux;
aux = abs(aux);
aux = find(aux);

end