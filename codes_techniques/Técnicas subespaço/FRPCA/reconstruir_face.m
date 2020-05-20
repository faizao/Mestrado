function yrs = reconstruir_face(E,imagem)
w = E'*imagem(:); %Realizo a reconstrução de toda a amostra
yrs = E*w;
end
