function im_recursiva = FastRecPCA(treinamento,teste)%(tre,teste,nome,destRec,pasta)

[U,imMedia] = calcPca(treinamento);


for i =1: size(teste,2)
    
    im_ocluida = teste(:,i);
    [im_teste,mascara] = pegarMascara(im_ocluida);
%     [l,~] = size(im_teste);
%     
%     disp(i);
    w_ant = U'*(im_ocluida - imMedia);
    w_pos = U'*(im_teste - imMedia);
    imRec = U*w_pos + imMedia;
    
    im_recursiva = mascara.*im_ocluida + (1- mascara).*imRec;
   
    d = max(abs(w_pos - w_ant));
%     fprintf('D: %0.2f \n',d);
    %reconstruir(im_recursiva,imRec,dim);
    alfa = 0.1;
    while d > 1e-3
%         fprintf('D: %0.2f \n',d);
    
        w_ant = w_pos;
        im3 = im_recursiva;
        w_pos = U'*(im3 - imMedia);
        w_pos = w_pos + alfa*(w_pos - w_ant); 
        imRec = U*w_pos + imMedia;
        
        im_recursiva = mascara.*im_recursiva + (1- mascara).*imRec;
       d = max(abs(w_pos - w_ant)); 
    end
    
%     verProjecao(im_recursiva);
   
end

end
