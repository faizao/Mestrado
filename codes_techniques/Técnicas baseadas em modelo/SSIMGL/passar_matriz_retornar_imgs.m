function list_images = passar_matriz_retornar_imgs(matriz)

dim = sqrt(size(matriz,1));

list_images = [];
for i=1: size(matriz,2)
    im = matriz(:,i);
    im = reshape(im,[dim dim]);
    list_images = [list_images,im];
    
end
list_images = uint8(list_images);
end