function sampleImgAll = normalizar_matriz(sampleImgAll)
sampleImgAllAvg=mean(sampleImgAll,1);
sampleImgAll=sampleImgAll-ones(size(sampleImgAll,1),1)*sampleImgAllAvg;

sampleImgAllNorm = sqrt( sum(sampleImgAll.^2,1) );
sampleImgAll = sampleImgAll./ (ones(size(sampleImgAll,1),1)*sampleImgAllNorm);



end