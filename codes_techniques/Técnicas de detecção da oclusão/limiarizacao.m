function [imNO, imO] = limiarizacao(teste) %Passar toda a matriz

[~,col] = size(teste);
imNO = [];
imO = [];

for i =1 : col
    im  = teste(:,i);
    imOcluida = teste(:,i);
    
    for k = 1 : size(im,1)
        if im(k,1) <= 75
            im(k,1) = 0;
            imOcluida(k,1) = 0;
        else
           imOcluida(k,1) = 255; 
            
        end
    end
      
    imNO = [imNO, im];
    imO = [imO, imOcluida];
    
end



end