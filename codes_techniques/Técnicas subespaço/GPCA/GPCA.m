function GPCA() %Implementação baseada no trabalho de Colombo(2008)
[X,X_o,nomes] = leituraArquivo(2,'true'); %lendo minha base
% X = X(:,1:40);

cont = 1;

w= sqrt(size(X,1));
h = w;

[d,qtde_imagens] = size(X_o);
[d q_i_n_o] = size(X);
% variancia = 95:-5:50;
% vet = [];

% pos = 12;
% vet = [vet,X_o(:,pos)];
% for var = 1: length(variancia)
%     v = variancia(var)*0.01;
[U,media,q_a_s] = calcPca(X);

for g = 12:qtde_imagens
    
    %for g = 1: qtde_imagens
    im_o = X_o(:,g);
%     pesos = (double(im_o) - media)' * U;
%     im_r = (U*pesos') + media;
    
%     dffs = norm(im_r);
%     mascara_oclusao = im_r - double(im_o);
    
    y = rand(q_a_s,1);
    
    
%     mascara_oclusao = uint8(mascara_oclusao);
%     if (dffs > 500)
%         for  i = 1:d
%             if mascara_oclusao(i) < 35
%                 z(i) = 1;
%             else
%                 z(i) = 0;
%             end
%         end
%     end
%     
%     z = reshape(z,[d,1]); %máscara da oclusão.
    [~,z] = pegarMascara(im_o);
    
    z = double(z);
    for i = 1:q_a_s %217 autovetores.
        soma = 0;
        vi = U(:,i);
        for j = 1:q_a_s %217 autovetores
            vj = U(:,j);
            su =sum((vj.*vi).*z) ;
            soma = soma + y(j)*su;
        end
        gradiente(i) = -2 * sum((double(im_o) - media).* (vi.*z)) + 2*soma;
        
    end
    it = 0;
    it_max = 200;
    alpha = 0.1;
    while norm(gradiente) > 1e-1 && it < it_max
        it = it + 1;
        for i = 1:q_a_s
            soma = 0;
            vi = U(:,i);
            for j = 1:q_a_s
                vj = U(:,j);
                soma = soma + y(j)*sum((vj.*vi.*z));
            end
            gradiente(i) = -2 * sum((double(im_o) - media).* (vi.*z)) + 2*soma;
        end
        soma_vi_yi = zeros(d,1);
        for i = 1:q_a_s
            soma_vi_yi = soma_vi_yi + y(i)*U(:,i);
        end
        P = (-im_o + media) + soma_vi_yi;
        erro =  P'*(P.*z);
        
        
        
        
        
        for i=1:q_a_s
            yaux(i)=y(i,1)- alpha*gradiente(i);
        end
        
        soma_vi_yi = zeros(d,1);
        for i = 1:q_a_s
            soma_vi_yi = soma_vi_yi + yaux(i)*U(:,i);
        end
        
        P = -im_o + media + soma_vi_yi;
        n_erro = P'*(P.*z) ;
        conterro = 0;
        while n_erro >= erro
            conterro = conterro+1;
            if(conterro > 50)
                erro = n_erro + 10;
            end
            alpha = alpha*0.9;
            for i=1:q_a_s
                yaux(i)=y(i)- alpha*gradiente(i);
            end
            soma_vi_yi = zeros(d,1);
            for i = 1:q_a_s
                soma_vi_yi = soma_vi_yi + yaux(i)*U(:,i);
            end
            
            P = -im_o + media + soma_vi_yi;
            n_erro = P'*(P.*z) ;
            fprintf('Novo erro> %.8f\n', n_erro);
        end
        
        y = yaux';
        alpha = alpha/0.9;
        
        disp(fprintf('IT> %d -- %0.4f\n', it,norm(gradiente)));
    end
    
    imagem_sem_oclusao = media;
    
    for i =1: q_a_s
        s = U(:,i)*yaux(i)';
        imagem_sem_oclusao = imagem_sem_oclusao + s;
    end
    a = reshape(im_o,[w h]);
    b = reshape(imagem_sem_oclusao,[w h]);
    c = [a,b];
    c = uint8(c);
    
    cd ('C:\Users\jonas\Desktop\conjuntos Yale\GPCA');
        imwrite(uint8(b),nomes{g});
    cd ..;
    imshow(c);
    %         imwrite(uint8(b),nomes{cont});
    
    cont = cont+1;
    disp('=========');
    disp(cont);
    disp('=========');
    
end
%     vet = [vet,b(:)];
% end

% verProjecao(vet);
% pause();

end


