function [set_Eigens,set_Amostras,set_amostras_pixels] = calc_low_Eig(treinamento,nPixels,nAmostras)
[d,~] = size(treinamento);


set_Amostras = {};
set_Eigens = {};
set_amostras_pixels = {};


for s = 1: nAmostras
    vet_m_Pixels = [];
    fprintf('amostra Tr:  %d \n', s );
    
    num = randperm(d,nPixels)'; %Pegando Mpixels
    vet_m_pixels = treinamento(num,:);
    set_Amostras{s} = num;
    set_amostras_pixels{s} = vet_m_pixels;
    [a_ve,~] = calcPca(vet_m_pixels);
    set_Eigens{s} = a_ve;
end

end