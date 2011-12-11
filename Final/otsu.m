name = 'im3';
I = imread([name '.jpg']);
figure(1);
imshow(I);
I_grey = rgb2gray(I);
figure(2);
imshow(I_grey);
level = graythresh(I_grey)
BW = im2bw(I,level);
figure(3);
imshow(BW)
imwrite(BW,[name '_otsu.png']);