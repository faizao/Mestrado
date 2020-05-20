function converterYale()
cd 'C:\Users\jonas\Google Drive\Base de Dados - Yale - AR\Yale faces\Não ocluídas';
k = 'imgs_Nao_Ocluidas';
mkdir(k);
di = dir;
arquivos = {di.name};
arquivos = arquivos(4:end);
%arquivos = {'dbf1','dbf2','dbf3','dbf4','dbf5','dbf6','dbf7'};

[~,c] = size(arquivos);

for i =1: c
    imagem = char(arquivos(i));
   
    im = imread(imagem);
    
    g = imresize(im,[128 128]);
    
    
    cd (k);
    im = strsplit(imagem,'.');
    im = strcat(im(1),im(2));
    im = char(im);
    save(strcat(im,'.mat'),'g');
    cd ..;

end