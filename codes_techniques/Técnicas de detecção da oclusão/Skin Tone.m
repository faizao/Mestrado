function skinColorCl()

cd 'C:\Users\jonas\Dropbox\USP\Qualificação\Base AR\Base Completa\AR Face - JPG_ 256\dbf1_JPG'

a = dir; % Recebe todo o diretório
b = {a.name}; %b = nome de todos os diretórios da pasta.
b = b(4:end); % b = 

[~,col] = size(b);

for k=1:col

    aux = char(b(k)); %converte para String o arquivo
    im=imread(aux); % Leio a imagem 
    [x,map] = rgb2ind(im,256);
    [w,h,a] = size(im);
    %========================
    for i=1 : w
        for j=1 : h
            I(i,j) = im(i,j,1)*0.298 + im(i,j,2)*0.587 + im(i,j,3)*0.140;
        end
    end
    imshow(I);
    pause();
    
    %=====================================
    for i=1: w
        for j = 1: h
            Ic(i,j) = max(im(i,j,2),im(i,j,3));
        end
    end
   %=====================================
   imshow(Ic);
   pause();
   E = I - Ic;
      
    for i = 1: w
        for j = 1: h
            if E(i,j) >= 8 && E(i,j) <= 26
            %if E(i,j) >= 0.2511 && E(i,j) <= 0.1177
                face(i,j) = 1;
            else
               face(i,j) = 0;
            end
        end
    end
    whos;
    imshowpair(im,face,'montage');
    pause(1);
   
    
    
    
    
end

end