function ver_projecao(vetor)
[lin,col] = size(vetor);
dim = sqrt(lin);

for i = 1: col
    im = vetor(:,i);
    im = reshape(im,[dim dim]);
    imshow(uint8(im));
     impixelinfo;
    pause();  
end