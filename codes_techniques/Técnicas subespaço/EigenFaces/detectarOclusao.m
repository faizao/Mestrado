function z = detectarOclusao(teste)
[lin,~] = size(teste);
dim = sqrt(lin);
z = [];

for i =1 : size(teste,2)
    im  = teste(:,i);
    
    for k = 1 : size(im,1)
        
       if im(k,1) <= 75
           
           im(k,1) = 0;
       else
           im(k,1) = 255;
       end
       
    end
    
    im = reshape(im,[dim dim]); %imagem após a remoção da oclusão
    imbw = im2bw(im);
    im2 = bwmorph(imbw,'erode');
    im2 = im2(:).*im(:); %imagem sem oclusão e com bwmorph
    z = [z,im2];
    imshow(im);
    pause();
%     im2 = reshape(im2,[dim dim]);
%     imaux = teste(:,i);
%     imaux = reshape(imaux,[dim dim]);
%     
%     subplot(1,3,1);imshow(uint8(imaux));title('Original');
%     subplot(1,3,2);imshow(uint8(im));title('sem oclusão');
%     subplot(1,3,3);imshow(uint8(im2)); title('filtro M');
%     impixelinfo;
%     pause();
end