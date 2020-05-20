function convertTamanho()
origem = 'C:\Users\jonas\Dropbox\USP\Qualificação\Base AR\Base Completa\AR Face - MAT_256';
cd(origem);
di = dir;
arquivos = {di.name};
arquivos = arquivos(3:6);

[~,c] = size(arquivos);

for i = 1:c
    cd(origem);
    d = char(arquivos(i)); 
    cd(d); % Entrei em cada pasta
    allFiles = dir;
    allNames = { allFiles.name };
    allNames = allNames(3:end);
    [~,cc] = size(allNames);
    destino = 'C:\Users\jonas\Dropbox\USP\Qualificação\Base AR\Base com oclusão';
    cd (destino)
    mkdir(d);
    
    cd (origem);
    cd(d); 
    
    cont = 1;
    for j = 1: cc  
        aux = char(allNames(j));
        k = strsplit(aux,'-');
        k = char(k(3));
        z = strsplit(k,'.');
        z = cell2mat(z(1));
        z = str2num(z);
        
        if z>=1 && z<= 7
            continue;
        end
        
        im = load(aux);
        im = im.g;
        cd(destino);
        cd(d);
        k = strsplit(aux,'.');
        k2 = char(k);
        save(strcat(k2(1,:),'.mat'),'im');
        cd(origem);
        cd(d);
        disp(sprintf('DB: %d e J: %d',i,j));
    end
    destino2 = 'C:\Users\jonas\Dropbox\USP\Qualificação\Base AR\Base com oclusão';
    cd (destino2)
    mkdir(d);
    
    

end

end