function Lfull = get_GL(tipo,dim)%GL = rotulada, Gu = Ocluída
fprintf('Generating Graph Laplace');
if strcmp(tipo,'poisson')
    adj = obter_matriz_adj(dim); % por default é (64,64)
  
else % utiliza laplace
    adj = obter_matriz_adj_8k();
    adj = pegar_dois_pixels_de_borda(adj);
    
end




s = [];
t = [];

for i =1: size(adj,1)
    linha = adj(i,:);
    
    adjacentes = find(linha ==1);
    
    for k = 1: length(adjacentes)
        s = [s,i];
        t = [t,adjacentes(k)];
        
        
    end 
end

vet = [s(:),t(:)];

vet = remover_duplicados(vet);

s = vet(:,1)';
t = vet(:,2)';

G = graph(s,t);
L = laplacian(G);
Lfull = full(L);
end



function adj = pegar_dois_pixels_de_borda(adj)

intervalo = 64;



for i =1: 64
    
    for j = 3: 64 -2
        pos_atual = ((j-1)*intervalo +1);
        pos_ant = pos_atual - 2*intervalo;
        pos_prox = pos_atual + 2*intervalo;
        adj(pos_atual,pos_ant) = 1;
        adj(pos_atual,pos_prox) = 1;

    end
end


end







