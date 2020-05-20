function Recursive_PCA() %Baseado no artigo 'Reconstruction of Partially Occluded face by fast recursive PCA'
[treinamento,teste,nomes] = leituraArquivo(2,'true');
% treinamento = treinamento(:,1:20);


[U,imMedia] = calcPca(treinamento);


for g =20: size(teste,2)
    im_ocluida = teste(:,g);
    
    [im_teste,mascara] = pegarMascara(im_ocluida); %peguei minha máscara;
    verProjecao([im_teste,mascara.*im_teste]);
  
    w = U'*(im_teste - imMedia);
    imRec = U*w + imMedia;
    
    im_recursiva = mascara.*im_ocluida + (1- mascara).*imRec;
    
    d = max(abs(im_recursiva - im_teste));
    
    verProjecao([im_recursiva,imRec]);
    
    while d > 1e-1
        fprintf('D: %0.2f \n',d);
        
        w_ant = w;
        im3 = im_recursiva;
        w = U'*(im3 - imMedia);
        imRec = U*w + imMedia;
        
        im_recursiva = mascara.*im_ocluida + (1- mascara).*imRec;
        
        
        
        verProjecao([im_ocluida,im_recursiva]);
        d = max(abs(w - w_ant));
%         pause();

    end
    cd ('C:\Users\jonas\Desktop\conjuntos Yale\Recursive PCA');
    imwrite(reshapeIm(im_recursiva),nomes{g});
    cd ..;
    
end
end



