%GU_bin = binário da matriz ocluída
%GU = pixels rotulados de GU
%GL = Matriz toda rotulada

function imagemRec = gerar_grafo(Lfull,GL,GU,GU_bin)


pos_ocluidas = ~logical(GU_bin);
pos_n_ocluidas = ~pos_ocluidas;

alfa=1;

% for i =1: 10 % 10 = para garantir que o alfa vá de [0,1]

Y =Lfull(:,pos_n_ocluidas);
Y = Y(pos_ocluidas,:);

X =Lfull(:,pos_ocluidas);
X = X(pos_ocluidas,:);

b = alfa*Lfull*GL; 

b = - Y*GU(pos_n_ocluidas) + b(pos_ocluidas);
A=Lfull(:,pos_ocluidas);
A = A(pos_ocluidas,:);

[x] = linsolve(A,b);
imagemRec = GU;
imagemRec(pos_ocluidas) = x;

% 
% verProjecao([individuo,GU,imagemRec],strcat('Alfa: ',num2str(alfa)));

% alfa = alfa + 0.1;
% pause(0.2);
end
