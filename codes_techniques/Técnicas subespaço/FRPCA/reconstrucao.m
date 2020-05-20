function reconstrucao(imMedia,erro_geral, erro_medio_amostra,erro_medio_geral, imagem,set_num_amostrados,E,nomes)

[H,vet_erro,vet_posicao]=criarMatrizH(erro_geral, erro_medio_amostra,erro_medio_geral, imagem,set_num_amostrados,E);

kpixels = [256,512, 1024,2048,4096];
for it = 1: size(kpixels,2)
    intervalo = kpixels(it);
    
    [~,pos] = sort(vet_erro); %Pego os pixels remanescentes com menor erro
    pos = pos(1:intervalo);
    pos = vet_posicao(pos);
    H(pos) = imagem(pos);
    
    yrs = imMedia + reconstruir_face(E,H);
    vetor = [imagem,H,yrs];
    
    %     ver_projecao(vetor,it);
    %     pause(0.5);
end
cd ('C:\Users\jonas\Desktop\conjuntos Yale\FPCA');
yrs = reshapeIm(yrs);
yrs = imresize(yrs,[128 128]);
imwrite(yrs,nomes);
cd ..;
end

