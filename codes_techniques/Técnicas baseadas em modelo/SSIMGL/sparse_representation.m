%rotulo_ts = rotulo do treinamento
%Y = é a imagem ocluida

function  labels_bests = sparse_representation(rotulo_ts,im_ocluida, A,label_tr,mascara)
p = mascara > 0; %aplicando a máscara

A = A(p,:);
im_ocluida = im_ocluida(p,:);

sc_algo= 'l1magic'; % Compute the sparse representation X
Ainv = pinv(A);



% Inital guess

xInit = Ainv *im_ocluida;

% sparse coding: solve a linear system
xp = sparse_coding_methods(xInit, A, im_ocluida, sc_algo);
[~ , posicoes ]= sort(xp,'descend'); %ordeno todos
labels_bests = label_tr(posicoes(1:30)); %Pego as 10 faces mais parecidas.


% pos_presentes = find(rotulos == rotulo_ts) %crio )


end