
function reconstrucao(imMedia,teste,U)
[l,c] = size(teste);
dim = sqrt(l);
imOcluidas = teste - repmat(imMedia,1,c);
w = U'*imOcluidas;
reconstrucao = U*w;
% destino = 'C:\Users\jonas\Dropbox\Workspace Matlab\Algoritmos Face\EigenFaces\ImgsReconstruidasAR';
% cd (destino);

    
for i =1 : size(reconstrucao,2)
    im  = teste(:,i);
    imReconstruida = imMedia + reconstrucao(:,i);
    imReconstruida = reshape(imReconstruida,[dim dim]);
    im = reshape(im,[dim dim]);
    a = [im,imReconstruida];
    imwrite(a,strcat(int2str(g),'.png'));
end



%z = detectarOclusao(teste);

%APCA(teste);

% for i =1 : size(z,2)
%     
%     im = z(:,i);
%     im = reshape(im,[dim dim]);
%     
%     imshow(uint8(im));
%     pause();
%     
% end
% 
% 
% 

%b = criarMatrizB(imMedia,teste);

% imOcl = z - repmat(imMedia,1,c);
% w2 = U'*imOcl;
% reconstrucao2 = U*w2;
% 
% for i =1 : size(reconstrucao,2)
%     im  = teste(:,i);
%     imReconstruida = imMedia + reconstrucao(:,i);
%     imReconstruida = reshape(imReconstruida,[dim dim]);
%     im = reshape(im,[dim dim]);
%     
%     imReconstruida2 = imMedia + reconstrucao2(:,i);
%     imReconstruida2 = reshape(imReconstruida2,[dim dim]);
%     
%     
%     subplot(1,3,1); imshow(uint8(im));title('original');
%     subplot(1,3,2); imshow(uint8(imReconstruida)); title('com oclusão');
%     subplot(1,3,3); imshow(uint8(imReconstruida2)); title('sem oclusão');
%     %imshowpair(im,imReconstruida,'montage');
%     impixelinfo;
%     pause();
% end

end
