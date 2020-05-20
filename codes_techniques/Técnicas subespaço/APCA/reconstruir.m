function reconstruir(im1,im2)
%cd ('C:\Users\jonas\Dropbox\Workspace Matlab\Algoritmos Face\Baseados em Subespaço\APCA\reconstrucao_AR');
%cd 'C:\Users\jonas\Desktop\yale';
dim = sqrt(size(im1,1));


im1 = reshape(im1,[dim dim]);
im2 = reshape(im2,[dim dim]);

%imshowpair(im1,im2,'montage');
imshow(uint8(im2));
%imwrite(uint8(im2),nomes{cont});
% cont = cont+1;
%cd ..
end