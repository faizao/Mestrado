function Fast_Recursive_PCA()
close all; clear; clc;
[treinamento,teste,nomes] = leituraArquivo(2,'true');

[U,imMedia] = calcPca(treinamento);


nit = 200;
for g =20: size(teste,2)
    im_ocluida = teste(:,g);
    
    [im_teste,mascara] = pegarMascara(im_ocluida); %pegando a máscara de oclusão
    
    
    w_ant = U'*(im_ocluida - imMedia); %pegando os coeficientes de combinação linear
    w_pos = U'*(im_teste - imMedia);
    
    imRec = U*w_pos + imMedia;
    
%     p = im_ocluida - imRec;
%     imshow(uint8(reshape(p,[128 128])));
%     %     verProjecao([im_ocluida,imRec,imRec - im_ocluida]);
%     %
%     pause(0.2);
%     continue;
    im_recursiva = mascara.*im_ocluida + (1- mascara).*imRec;
    
    d = max(abs(w_pos - w_ant));
    %fprintf('D: %0.2f \n',d);
    verProjecao([im_recursiva,imRec]);
    
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
        
        
        
        verProjecao([im_ocluida,im_recursiva]);
        d = max(abs(w_pos - w_ant));

        
        iteracao = iteracao+1;
        
    end
    im_recursiva = reshapeIm(im_recursiva);
    cd('C:\Users\jonas\Desktop\conjuntos Yale\Fast Rec PCA');
    imwrite(im_recursiva,nomes{g});
    cd ..;
    
end

end