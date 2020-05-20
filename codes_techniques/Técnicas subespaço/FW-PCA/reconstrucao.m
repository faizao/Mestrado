function reconstrucao(imMedia,erro_geral, erro_medio_amostra,erro_medio_geral, imagem,set_num_amostrados,E)

[H,vet_erro,vet_posicao,yrs]=criarMatrizH(erro_geral, erro_medio_amostra,erro_medio_geral, imagem,set_num_amostrados,E);

kpixels = [2048];
n = 1.8; % Valor default definido pelo artigo
for it = 1: 4
    intervalo = kpixels(1);
    w = abs(yrs - imagem);
    desvio = std(w);
    teta = n*desvio;
    
    aux = w > teta;
    H(aux) = 0;
    
%     yrs = yrs
%     
%     
%     [~,pos] = sort(vet_erro); %Pego os pixels remanescentes com menor erro
%     pos = pos(1:intervalo);
%     pos = vet_posicao(pos);
%     H(pos) = imagem(pos);
    
    yrs = imMedia + reconstruir_face(E,H,imagem);
    
    vetor = [imagem,H,yrs];
    
    ver_projecao(vetor,it);
    pause(0.5);   
end
end


