function converterRawParaJpg()

cd('C:\Users\jonas\Google Drive\BASE AR\AR - 256x256\AR Face - RAW')
%arquivos = {'dbf8'};
arquivos = {'dbf1','dbf2','dbf3','dbf4','dbf5','dbf6','dbf7','dbf8'};

[~,c] = size(arquivos);


for i = 1:c
    d = char(arquivos(i)); 
    cd(d); % cd ('dbf1')
    allFiles = dir;
    allNames = { allFiles.name };
    allNames = allNames(3:end);
    
    [~,cc] = size(allNames);
      
    s = strcat(d,'_Mat');
    mkdir(s);
    
    for j = 1: cc  
        aux = char(allNames(j));
            
        row=576;  col=768;
        
        fin=fopen(aux,'r');
        %I=fread(fin,'uint8=>uint8'); %// Read in as a single byte stream
        I=fread(fin, col*row*3,'uint8=>uint8'); %// Read in as a single byte stream
        I = reshape(I, [col row 3]); %// Reshape so that it's a 3D matrix - Note that this is column major
        Ifinal = flipdim(imrotate(I, -90),2); % // The clever transpose
        %imshow(Ifinal);
        f = imresize(Ifinal,[64 64]);   
        %g = rgb2gray(f);
        cd(s);    
        k = strsplit(aux,'.');
        k2 = char(k);
        save(strcat(k2(1,:),'.mat'),'g');
        %imwrite(f,strcat(k2(1,:),'.jpg'));
        
        fclose(fin);
        cd .. ;
        disp(sprintf('DB: %d e J: %d',i,j));
      
    end
    cd ..


end

end