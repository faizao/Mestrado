function im_recursiva = FRECPCA(treinamento,teste)

[U,imMedia] = calcPca(treinamento);


nit = 200;

im_ocluida = teste;

[im_teste,mascara] = pegarMascara(im_ocluida); %pegando a máscara de oclusão
% mascara = bwmorph(mascara,'erode');
% mascara = bwmorph(mascara,'erode');


w_ant = U'*(im_ocluida - imMedia); %pegando os coeficientes de combinação linear
w_pos = U'*(im_teste - imMedia);

imRec = U*w_pos + imMedia;


im_recursiva = mascara.*im_ocluida + (1- mascara).*imRec;

d = max(abs(w_pos - w_ant));
%fprintf('D: %0.2f \n',d);
% verProjecao([im_recursiva,imRec]);

alfa = 0.5;
iteracao  = 0;
while d > 1e-1 && iteracao <= nit
    fprintf('D: %0.2f | iteracao: %i \n',d,iteracao);
    
    w_ant = w_pos;
    im3 = im_recursiva;
    w_pos = U'*(im3 - imMedia);
    w_pos = w_pos + alfa*(w_pos - w_ant);
    imRec = U*w_pos + imMedia;
    
    im_recursiva = mascara.*im_recursiva + (1- mascara).*imRec;
    
    
    
%     verProjecao([im_ocluida,im_recursiva]);
    d = max(abs(w_pos - w_ant));
    iteracao = iteracao+1;  
end
%  verProjecao([im_ocluida,im_recursiva]);


end