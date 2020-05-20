function [tr,ts] = redimensionar_64(treinamento,teste)
[lin,col] = size(treinamento);
dim = sqrt(lin);
tr = [];
for i =1: col
   im = treinamento(:,i);
   im = reshape(im,[dim dim]);
   im = imresize(im,[64 64]);
   tr = [tr,im(:)];
end


[~,col] = size(teste);
ts = [];
for i =1: col
   im = teste(:,i);
   im = reshape(im,[dim dim]);
   im = imresize(im,[64 64]);
   ts = [ts,im(:)];
end


end