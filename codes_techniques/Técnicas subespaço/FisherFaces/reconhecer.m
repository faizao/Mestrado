function reconhecer(imMedia,teste,U,m,W)
U = U(:,1:m);
[l,c] = size(teste);
dim = sqrt(l);
imOcluidas = teste - repmat(imMedia,1,c);
w = U'*imOcluidas;
size(w)
reconstrucao = U*w;
    
for i =1 : size(reconstrucao,2)
    im  = teste(:,i);
    imReconstruida = imMedia + reconstrucao(:,i);
    imReconstruida = reshape(imReconstruida,[dim dim]);
    im = reshape(im,[dim dim]);
    %wAux = w(i,:);
    
    
    a = [im,imReconstruida];
    a = uint8(a);
    imshow(a);
    pause();
end


end
