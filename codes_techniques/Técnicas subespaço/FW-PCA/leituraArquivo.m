function [treinamento,teste] = leituraArquivo(db,origem)
destino = 'C:\Users\jonas\Dropbox\Workspace Matlab\Base de dados face';
cd (destino);
[treinamento,teste] = leituraArquivo(db);
cd (origem);
end