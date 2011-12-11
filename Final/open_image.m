name = 'im3_otsu';
I = imread([name '.png']);
figure(3);
imshow(I);
se = strel('disk',2);
I_opened = imopen(I,se);
figure(4);
imshow(I_opened);
imwrite([name '_opened.png']);