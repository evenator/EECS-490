name1 = 'im3';
name = 'im3_otsu';
I = imread([name '.png']);
figure(3);
imshow(I);
se = strel('disk',15);
I_eroded = imerode(I,se);
figure(4);
imshow(I_eroded);
imwrite(I_eroded, [name '_eroded.png']);
name = name1;
display_seeds;