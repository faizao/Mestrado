clear;close;clc;origem = pwd;cd (origem);

addpath(genpath(pwd));



[treinamento_comp,teste_comp,~,numClass] = leituraArquivo(1,[],'false');
[trainLabel,testLabel_comp] = gerar_rotulos(treinamento_comp,teste_comp,numClass);%Gerando rótulos

num_pixels = 400;

for i =1: size(teste_comp,2)

testLabel = testLabel_comp(i);
teste = teste_comp(:,i);
[mascara, ~] = pegarMascara(teste);
p = mascara > 0;

treinamento = treinamento_comp(p,:);
treinamento = treinamento(1:num_pixels,:);

teste = mascara(p,:);
teste = teste(1:num_pixels,:);

% tam = 20;
% conj.treinamento = double(processar(conj.treinamento,tam));
% conj.teste = double(processar(conj.teste,tam));

treinamento = normalizar_matriz(treinamento);
teste = normalizar_matriz(teste);


trainSample = treinamento;
testSample = teste;



call_SRC(testSample, trainSample,trainLabel, testLabel, numClass);

end







