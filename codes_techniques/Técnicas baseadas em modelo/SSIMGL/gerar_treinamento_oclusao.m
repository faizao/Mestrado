function [new_tr,new_ts] = gerar_treinamento_oclusao(mascara,treinamento)
posicoes = mascara >0;
new_tr = treinamento(posicoes,:);
new_ts = mascara(posicoes,:);
end