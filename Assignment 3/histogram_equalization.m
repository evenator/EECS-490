%Load the image
im_in = imread('phobos_X.tif');
figure(1);
imshow(im_in);
title('Input Image');

%Show histogram
histo_in = imhist(im_in)
figure(2);
plot(histo_in);
title('Input Image Histogram');

%Run histeq with default parameters
im_out_1 = histeq(im_in);
figure(3);
imshow(im_out_1);
title('HistEQ with Default Parameters');
figure(4);
histo_1 = imhist(im_out_1);
plot(histo_1);
title('HistEQ with Default Parameters');