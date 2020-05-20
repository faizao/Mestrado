function yrs = reconstruir_face(E,H,im_ocluida)
% pos = H>0;
% H(pos) = 1;
w = E'*H(:); %Realizo a reconstrução de toda a amostra
yrs = E*w;

% a = (E.^2)'*H;
% b = E'*im_ocluida;
% % whos;
% % pause();
% % a = (E.^2)'.*(E'*(H.*im_ocluida));
% w = a.*b;
% % waux = a./ (E.^2)'*H;
% waux = w./a;
% % k = [w,waux]
% % pause();
% yrs = E*waux;

end
