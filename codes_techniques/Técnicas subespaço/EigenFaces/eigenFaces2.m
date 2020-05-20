function eigenFaces2()%(tre,teste,nome,destRec,pasta)
close; clear; clc; 
[treinamento,teste] = leituraArquivo(1,'false');

treinamento = treinamento(:,1:100);
% 
% 
% 
% 
% teste = teste(:,1:8);
[teste,teste2] = pegarMascara(teste);
% 
% for i=1: size(teste,2)
%    im = teste(:,i);
%    im = reshape(im,[128 128]);
%    imshow(uint8(im));
%    pause(0.5);
% end


[U,imMedia] = calcPca(treinamento);

[l,c] = size(teste);
dim = sqrt(l);
imOcluidas = teste - repmat(imMedia,1,c);
w = U'*imOcluidas;
reconstrucao = U*w;

for i =1 : size(reconstrucao,2)
    disp(i);
    imReconstruida = imMedia + reconstrucao(:,i);
    imReconstruida = reshape(imReconstruida,[dim dim]);
    imshow(uint8(imReconstruida));
    pause(0.5);
   % imwrite(uint8(imReconstruida),strcat(a,'.png'));
   
 
    
end
