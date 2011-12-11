name = 'im3';
I = imread([name '.jpg']);
figure(1);
imshow(I);
I_grey = rgb2gray(I);
figure(2);
imshow(I_grey);

h = fspecial('laplacian');
I_laplacian = imfilter(I,h);
figure(3);
imshow(I_laplacian)
%imwrite(edges,[name '_edges.png']);