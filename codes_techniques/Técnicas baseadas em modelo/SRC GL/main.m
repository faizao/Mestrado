function main()
addpath(genpath('C:\Users\jonas\Dropbox\Workspace Matlab\Algoritmos Face\GL'));
warning off;
clear; clc;close;
gerente_main();

end

function gerente_main()
raiz = pwd;
grafos = {'poisson','laplace'};

for g=1: length(grafos)
    cd(raiz);
    grafo = grafos{g};
    diretorio = strcat('Reconstrucao_Yale_',grafo);
    mkdir(diretorio); cd(diretorio); %entrando no diretorio
    raiz2 = pwd;
    
    
    for i =1: 2 %vou rodar isso para 4 bases
        cd(raiz2);
        switch i
            
            case 1
                [treinamento,teste,~,classes] = leituraArquivo(1,'false'); %pegando o treinamento e teste
                tipo_base = 'AR completa';
                conj = atribuir_Conjunto(treinamento,teste,classes); %atribuindo uma variável apenas para tudo
                executar(conj,grafo,tipo_base);
            otherwise
                [treinamento,teste,~,classes] = leituraArquivo(2,[],'false'); %pegando o treinamento e teste
                tipo_base = 'Yale_Com_Cachecol';
                conj = atribuir_Conjunto(treinamento,teste,classes); %atribuindo uma variável apenas para tudo
                executar(conj,grafo,tipo_base);
                
                
                
        end
        
    end

    
end
end


function conj = atribuir_Conjunto(tr,ts,classes)
conj.treinamento = tr;
conj.teste = ts; %atribuindo tudo a uma variável apenas, no caso conj
conj.numClass = classes;
end


function executar(conj,tipo_grafo,tipo_base)
mkdir(tipo_base); %criando o diretorio do tipo da base e entrando nele
cd(tipo_base); %entrando na base para inserir as imagens aqui
SRC(conj,tipo_grafo); %passo o treinamento, o teste e o tipo de grafo
% cd ..;
end


