function ver_projecao(vetor,it)
switch nargin
    case 2
        [lin,col] = size(vetor);
        vetor = uint8(vetor);
        dim = sqrt(lin);
        
        aux = [];
        
        for i =1: col
            im = vetor(:,i);
            im = reshape(im,[dim dim]);
            aux = [aux,im];
        end
        imshow(aux);
        title(strcat('iteração: ',int2str(it)));
        pause(0.5);
        
    otherwise
        [lin,col] = size(vetor);
        vetor = uint8(vetor);
        dim = sqrt(lin);
        
        aux = [];
        
        for i =1: col
            im = vetor(:,i);
            im = reshape(im,[dim dim]);
            aux = [aux,im];
        end
        imshow(aux);
        %title(strcat('iteração: ',int2str(it)));
        pause(0.5);
end

end