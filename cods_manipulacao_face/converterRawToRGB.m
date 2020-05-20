function converterRawToRGB()
cd('C:\Users\jonas\Dropbox\dbf1');
row=576;  col=768;

fin=fopen('m-001-1.raw','r');
fin
%I=fread(fin,'uint8=>uint8'); %// Read in as a single byte stream
I=fread(fin, col*row*3,'uint8=>uint8'); %// Read in as a single byte stream
I = reshape(I, [col row 3]); %// Reshape so that it's a 3D matrix - Note that this is column major
Ifinal = flipdim(imrotate(I, -90),2); % // The clever transpose
imshow(Ifinal);
f = imresize(Ifinal,[256 256]);
cd ..
imwrite(f,'teste.jpg');
%saveas(Ifinal,'teste.jpg');
%fclose(fin);
end