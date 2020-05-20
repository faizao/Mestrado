function [U,imMedia] = calcPca(treinamento)
% [~,col] = size(treinamento);
% k = col;
% imMedia = mean(treinamento,2);
% A = treinamento - repmat(imMedia,1,col);% conjunto fi
% C = A'*A; % Covariância(M,M)
% [autovetores,autovalores] = eig(C);
% 
% U = A*autovetores; % Matriz de fi
% [~ , i] = sort ( diag (autovalores) , 'descend');
% U = U (: , i );
% U = U (: ,1: k);
% for i = 1: size(U,2)
%     U(:,i) = U(:,i)/norm(U(:,i)); % normalizando minhas eigenFaces
% end
[lin,col] = size(treinamento);


imMedia = mean(treinamento,2);
A = treinamento - repmat(imMedia,1,col);% conjunto fi
C = A'*A; % Covariância(M,M)
[autovetores,ava] = eig(C);

U = A*autovetores; % Matriz de fi
[ava , i] = sort ( diag (ava) , 'descend');


eigsum = sum(ava);
csum = 0;
for j = 1:lin
    csum = csum + ava(j);
    tv = csum/eigsum;
    if tv > 0.95
        k = j;
        break
    end ;
end;


U = U (: , i );
U = U (: ,1: k);
for i = 1: size(U,2)
    U(:,i) = U(:,i)/norm(U(:,i)); % normalizando minhas eigenFaces
end


end


