function call_SRC(testSample, trainSample,trainLabel, testLabel, numClass)
redundencyFactor = 2;                           % The number of the atoms = data dimension x redundencyFactor 
param.L = 10;                                   % The number of atoms used in representation a signal
param.InitializationMethod =  'DataElements';   % Initialize a dictionary with random sampling
param.errorFlag = 0;                            % Decompose signal without reaching an error bound
param.K = redundencyFactor*size(trainSample,1); % The number of atoms in the dictionary
param.numIteration = 5;                         % The number iteration for the K-SVD algorithm 
param.preserveDCAtom = 0;                       % Presearve a DC atom or not
param.displayProgress= 1;                       % Display the progress and the error at each iteration

% K-SVD dictionary learning
fprintf('K-SVD dictionary learning...\n');
[Dictionary,output] = KSVD(trainSample, param);

%% Sparsity coding based classification

sc_algo= 'l1magic';         % Select one sparse coding method
displayProgressFlag = 1;    % Display the prediction progress
FastSparseCodingFag = 1;    % Use fast sparse coding
fprintf('Solving sparse coding...\n');

if(FastSparseCodingFag)
    [X, accuracy, avgTime] = fsc_main(testSample, trainSample, Dictionary, param.L, sc_algo, trainLabel, testLabel, numClass, displayProgressFlag);
else
    [X, accuracy, avgTime] = sc_main(testSample, trainSample, sc_algo, trainLabel, testLabel, numClass, displayProgressFlag);
end

% Report the classification accuracy and the speed

fprintf('Sparse coding method: %s.\n', sc_algo);
fprintf('The accuracy of the classification task is %f %%.\n', accuracy*100);
fprintf('The average speed of sparse coding is %s second.\n', avgTime);


end