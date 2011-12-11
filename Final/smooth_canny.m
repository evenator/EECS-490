name = 'im3';
I = imread([name '.jpg']);
figure(1);
imshow(I);
I_grey = rgb2gray(I);
figure(2);
imshow(I_grey);

h = fspecial('gaussian',[7 7]);
I_smooth = imfilter(I_grey,h);
figure(3);
imshow(I_smooth)

edges = edge(I_smooth,'canny');
figure(4);
imshow(edges)