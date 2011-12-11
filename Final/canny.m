name = 'im3';
I = imread([name '.jpg']);
figure(1);
imshow(I);
I_grey = rgb2gray(I);
figure(2);
imshow(I_grey);
edges = edge(I_grey,'canny');
figure(3);
imshow(edges)
%imwrite(edges,[name '_edges.png']);