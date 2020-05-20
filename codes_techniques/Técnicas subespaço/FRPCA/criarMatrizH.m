%cria a matriz de erros por imagem e por amostra
function [H,vet_erro,vet_posicao]=criarMatrizH(erro_geral, erro_medio_amostra,erro_medio_geral, imagem,set_num_amostrados,E)
[lin,num_amostras] = size(erro_geral);
H= imagem;
vet_erro =[];
vet_posicao = [];

for i=1: num_amostras % vá em cada amostra
       
    rs = erro_geral(:,i); %Pegue o erro geral de toda aquela amostra para aquela imagem
    
    numeros_amostrados = set_num_amostrados{i}; %Pegue os números amostrados
     
    for j=1: lin
        if (rs(j) > 1*erro_medio_amostra(i)) || (rs(j) > erro_medio_geral)
            vet_erro = [vet_erro,rs(j)];
             posicao = numeros_amostrados(j);
            vet_posicao = [vet_posicao, posicao];
            H(posicao) = 0;
       end

    end
end

yrs = reconstruir_face(E,H);
vetor = [imagem, H, yrs];
ver_projecao(vetor);
end