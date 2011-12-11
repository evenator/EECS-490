name = 'im3';
I = imread([name '.jpg']);
figure(1);
imshow(I);
I_grey = rgb2gray(I);
figure(2);
imshow(I_grey);

h = fspecial('average',[5 5]);
I_smooth = imfilter(I_grey,h);
figure(3);
imshow(I_smooth)
%imwrite(edges,[name '_edges.png']);