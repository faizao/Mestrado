%retorna duas imagens, a primeira sendo o GPCA puro e a segunda sendo o
%GPCA modificado
function [im_rec,im_rec2] = GPCA(tr,im_o) %Implementação baseada no trabalho de Colombo(2008)

[d,~] = size(im_o);
media = mean(tr,2);
[autovetores,~,q_a_s] = calcPca(tr);

y = rand(q_a_s,1);
[mascara,z] = pegarMascara(im_o);
z = double(z);
for i = 1:q_a_s
    soma = 0;
    vi = autovetores(:,i);
    for j = 1:q_a_s
        vj = autovetores(:,j);
        su =sum((vj.*vi).*z) ;
        soma = soma + y(j)*su;
    end
    gradiente(i) = -2 * sum((double(im_o) - media).* (vi.*z)) + 2*soma;
    
end
it = 0;
it_max = 200;
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
    
    disp(fprintf('\n IT> %d -- %0.4f\n', it,norm(gradiente)));
end

im_rec = media;

for i =1: q_a_s
    s = autovetores(:,i)*yaux(i)';
    im_rec = im_rec + s;
end

 im_rec2 = z.*mascara + (1- z).*im_rec;





end


