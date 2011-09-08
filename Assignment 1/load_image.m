%Load image
img_in = imread('test.jpg','jpg');
img_in = rgb2gray(img_in);
[rows, cols] = size(img_in);
figure(1)
imshow(img_in)
truesize;
title('Original Image')