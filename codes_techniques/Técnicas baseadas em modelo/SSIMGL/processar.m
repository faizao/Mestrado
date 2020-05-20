function conj = processar(conjunto,dim)
conj = [];
for i =1: size(conjunto,2)
    im = conjunto(:,i);
    im = reshapeIm(im);
    im = imresize(im,[dim NaN],'bilinear');
    conj = [conj,im(:)];
    
    
    
end



end