function reconstrucao_APCA(bin,teste,imMediaNO,imMediaOri,fiP,fiNO,nome)

[lin,col] = size(teste);
%dim = sqrt(lin);
origem = pwd;
% cd ('C:\Users\jonas\Desktop\APCA');
for  i = 1: col
    imagem = teste(:,i) - imMediaNO;
    alfaNO = imagem'*fiNO;
 
    imR = imMediaOri + fiP*alfaNO' ;
    imR(bin)= teste(bin);
%     imR = reshapeIm(imR);
%     imwrite(imR,nome);
%     imR = uint8(reshape(imR,[dim dim]));
    
%     verProjecao([teste(:,i),imR]);
%     pause();
    imR = reshapeIm(imR);
    cd ('C:\Users\jonas\Desktop\conjuntos Yale\APCA');
    imwrite(imR,nome);
    cd ..;
%     aux = nomes{i};
%     a = strsplit(aux,'.');
%     a = cellstr(a(1));
%     a = char(a(:));
%     
%     imwrite(uint8(imR),strcat(a,'.png'));
    
end
cd(origem);
end
