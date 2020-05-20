%Implementação baseada no trabalho de Colombo(2008)
function GPCA2(tr,ts,nomes,destRec,pastaStorage)


cont = 1;
X = tr;
X_o = ts;
w= sqrt(size(X,1));
h = w;

[d, q_i_o] = size(X_o);
%[~, q_i_n_o] = size(X);
media = mean(X,2);
[autovetores,q_a_s] = calcPca(X);



for g = 1: q_i_o
    im_o = X_o(:,g);
    pesos = (double(im_o) - media)' * autovetores;
    im_r = (autovetores*pesos') + media;
    
    dffs = norm(im_r);
    mascara_oclusao = im_r - double(im_o);
    
    y = rand(q_a_s,1);
    
    mascara_oclusao = uint8(mascara_oclusao);
    if (dffs > 500)
        for  i = 1:d
            if mascara_oclusao(i) < 35
                z(i) = 1;
            else
                z(i) = 0;
            end
        end
    end
    
    
    z = reshape(z,[d,1]); %máscara da oclusão.
    
    z = double(z);
    for i = 1:q_a_s %217 autovetores.
        soma = 0;
        vi = autovetores(:,i);
        for j = 1:q_a_s %217 autovetores
            vj = autovetores(:,j);
            su =sum((vj.*vi).*z) ;
            soma = soma + y(j)*su;
        end
        gradiente(i) = -2 * sum((double(im_o) - media).* (vi.*z)) + 2*soma;
        
    end
    it = 0;
    it_max = 10000;
    alpha = 0.1;
    while norm(gradiente) > 1e-3 && it < it_max
        it = it + 1;
        for i = 1:q_a_s
            soma = 0;
            vi = autovetores(:,i);
            for j = 1:q_a_s
                vj = autovetores(:,j);
                soma = soma + y(j)*sum((vj.*vi.*z));
            end
            gradiente(i) = -2 * sum((double(im_o) - media).* (vi.*z)) + 2*soma;
        end
        soma_vi_yi = zeros(d,1);
        for i = 1:q_a_s
            soma_vi_yi = soma_vi_yi + y(i)*autovetores(:,i);
        end
        P = (-im_o + media) + soma_vi_yi;
        erro =  P'*(P.*z);
        
        
        
        
        
        for i=1:q_a_s
            yaux(i)=y(i,1)- alpha*gradiente(i);
        end
        
        soma_vi_yi = zeros(d,1);
        for i = 1:q_a_s
            soma_vi_yi = soma_vi_yi + yaux(i)*autovetores(:,i);
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
                soma_vi_yi = soma_vi_yi + yaux(i)*autovetores(:,i);
            end
            
            P = -im_o + media + soma_vi_yi;
            n_erro = P'*(P.*z) ;
            fprintf('Novo erro> %.8f\n', n_erro);
        end
        
        y = yaux';
        alpha = alpha/0.9;
        
        disp(sprintf('IT> %d -- %0.4f\n', it,norm(gradiente)));
        %disp(sprintf('Erro  %0.8f  alfa %3.4f\n', n_erro,alpha));
    end
    
    imagem_sem_oclusao = media;
    
    for i =1: q_a_s
        s = autovetores(:,i)*yaux(i)';
        imagem_sem_oclusao = imagem_sem_oclusao + s;
    end
    %a = reshape(im_o,[w h]);
    b = uint8( reshape(imagem_sem_oclusao,[w h]));
    cd(destRec);
    cd (pastaStorage);
    
    aux = nomes{g};
    a = strsplit(aux,'.');
    a = cellstr(a(1));
    a = char(a(:));
    
    imwrite(b,strcat(a,'.png'));
    
    
%     imwrite(b,nomes{cont});
%     cd ..;
    
    cont = cont+1;
    disp('=========');
    disp(cont);
    disp('=========');
    
end


end



