function set = redimensionar(conjunto,dim)
set = [];
tamanho = sqrt(size(conjunto,1));
for i =1: size(conjunto,2)
    im = conjunto(:,i);
    im = reshape(im,[tamanho tamanho]); %Estou redimensionando com iniciativas a demorar menos tempo a SR
    im = uint8(im);
    im = imresize(im,[dim dim]);
    im = double(im);
    set = [set,im(:)];
end

end