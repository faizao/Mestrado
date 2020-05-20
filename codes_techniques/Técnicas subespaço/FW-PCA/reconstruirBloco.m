function [erro_geral, erro_medio_amostra,erro_medio_geral] = reconstruirBloco(U,num_amostrados,teste,set_amostras_pixels)

qtde_amostras = size(U,2);
erro_geral = [];
erro_medio_amostra = [];

for i=1 : qtde_amostras % vou em cada amostra
    u = U{i}; % e gero o eigenspace dela
    numeros_amostrados = num_amostrados{i};
    conjunto = set_amostras_pixels{i};
    media_conjunto = mean(conjunto,2);
    ys = teste(numeros_amostrados,:) - media_conjunto;
    w = u'*ys; %Realizo a reconstrução de toda a amostra
    yrs = u*w;
    yrs = yrs+ media_conjunto;
    rs = abs(ys - yrs); %Analiso o erro de reconstrução
    
    erro_geral = [erro_geral,rs];
    rs = mean(rs);
    erro_medio_amostra = [erro_medio_amostra,rs];
end
erro_medio_geral = mean(erro_medio_amostra);
end


