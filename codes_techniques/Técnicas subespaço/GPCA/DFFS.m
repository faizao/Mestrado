function DFFS (imMedia,teste,U)
[l,c] = size(teste);
A = teste - repmat(imMedia,1,c);
w = U'*A;
reconstrucao = U*w;
format long;
dffs = [];
for i=1: c
   e = teste(:,i) - imMedia - reconstrucao(:,i);
    e = norm(e);
    dffs = [dffs;e];
   
    
end
% %
% mi = min(dffs)
% ma = max(dffs)
% me = mean(dffs)
% de = std(dffs)
% a = (dffs > 500);
%  sum(a)

end