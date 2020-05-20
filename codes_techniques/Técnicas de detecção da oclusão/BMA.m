function [vet,vet2] = deteccao_blocos(teste)
[lin,qtde_imgs] = size(teste);
dim = sqrt(lin);

teste = detector_oclusao_limiar(teste);
dim_mascara = 2; % Já que a imagem é 128x128 é interessante colocar uma mascara múltipla de 2,4,8,16,32 e 64.

vet = [];
vet2 = [];
for im =1: qtde_imgs
    
    imagem = teste(:,im);
    imagem = reshapeIm(imagem);
    
    for i=1:dim_mascara:dim
        
        for k=1:dim_mascara:dim
            mascara = imagem(i:i+dim_mascara-1,k:k+dim_mascara-1); % função para pegar a máscara
            [l,c] = size(mascara);
            tamMascara = l*c; %Pegar a quantidade pixels existentes
            
            pixelsOcluidos = find(mascara == 0); % Olhar quais pixels estão ocluídos
            [l,c] = size(pixelsOcluidos);
            tamPixelsOcluidos = l*c; %Olhando o percentual de pixels ocluídos
            
            percentual = (tamPixelsOcluidos*100)/tamMascara; %Percentual de pixels ocluídos
            
            if percentual >= 25 %Se o percentual de pixels ocluídos for maior que 25% deixo todo o bloco preto.
                imagem(i:i+dim_mascara-1,k:k+dim_mascara-1) = 0;
            end
            
        end
    end
    
    bin = imagem > 0;
    bin = bwmorph(bin,'erode');
    bin = bwmorph(bin,'dilate');
    bin = bwmorph(bin,'dilate');
    bin = bwmorph(bin,'erode');
    bin = bwmorph(bin,'erode');
    bin = bwmorph(bin,'erode');
    bin = bwmorph(bin,'erode');
    bin = bwmorph(bin,'erode');
    bin = bwmorph(bin,'erode');
    bin = bwmorph(bin,'dilate');
    bin = bwmorph(bin,'dilate');
    bin = bwmorph(bin,'dilate');
    vet2 = [vet2,bin(:)];
    p = bin == 0;
    imagem(p) = 0;
    vet = [vet,imagem(:)];
end

vet = double(vet);


end




