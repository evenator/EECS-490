name = 'im3';
I = imread([name '.jpg']);
figure(1);
imshow(I);
I_grey = rgb2gray(I);
figure(2);
imshow(I_grey);

h = fspecial('laplacian');
I_laplacian = imfilter(I_grey,h);
figure(3);
imshow(I_laplacian)
%imwrite(edges,[name '_edges.png']);

otsu_input = I_laplacian .* I_grey;
figure(4);
imshow(otsu_input);

thresh = graythresh(otsu_input);
BW = im2bw(I_grey,thresh);
figure(5);
imshow(BW)