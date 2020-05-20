function converterJPG_To_Gray()
clc ;
origem = 'C:\Users\jonas\Dropbox\USP\Qualificação\Base AR\Base Completa\AR Face - JPG_ 256';
destino1 = 'C:\Users\jonas\Dropbox\USP\Qualificação\Base AR\Base Completa\AR Face - Mat_128\imgs_Treinamento';
destino2 = 'C:\Users\jonas\Dropbox\USP\Qualificação\Base AR\Base Completa\AR Face - Mat_128\imgs_Teste';
cd(origem)
di = dir;
arquivos = {di.name};
arquivos = arquivos(3:end);
%arquivos = {'dbf1','dbf2','dbf3','dbf4','dbf5','dbf6','dbf7'};

[~,c] = size(arquivos);



for i = 1:c
    
    cd(origem);
    d = char(arquivos(i)); 
    cd(d); % cd ('dbf1')
    allFiles = dir;
    allNames = { allFiles.name };
    allNames = allNames(4:end);
    
    [~,cc] = size(allNames);
    
    quebra = strsplit(d,'_');
    quebra = char(quebra);
    quebra = quebra(1,:);
    
    cd (destino1);
    s = strcat(quebra,'_128');
    mkdir(s);
    
    cd (destino2);
    s = strcat(quebra,'_128');
    mkdir(s);
    
    
    for j = 1: cc 
        cd (origem);
        cd (d);
        aux = char(allNames(j));
            
        
        f = imread(aux);
        g = imresize(f,[128 128]);
        g = rgb2gray(g);
        q = strsplit(aux,'-');
        
        q = char(q);
        
        q = q(3,:);
        q = strsplit(q,'.');
        a = q(1);
        a = cell2mat(a);
        q = str2num(a);
        
        if q< 8
            cd (destino1);
            cd (s);            
            k = strsplit(aux,'.');
            k2 = char(k);
            save(strcat(k2(1,:),'.mat'),'g');
            disp(sprintf('DB: %d e J: %d',i,j));
            
        elseif q>=8
            cd (destino2);
            cd (s);
            k = strsplit(aux,'.');
            k2 = char(k);
            save(strcat(k2(1,:),'.mat'),'g');
            disp(sprintf('DB: %d e J: %d',i,j));
        end
      
    end
    


end

end