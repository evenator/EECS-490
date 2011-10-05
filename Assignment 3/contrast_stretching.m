%Load the image
im_in = imread('phobos_X.tif');
figure(1);
imshow(im_in);
title('Input Image');

%Show histogram
histo_in = imhist(im_in);
figure(2);
plot(histo_in);
title('Input Image Histogram');

%Run imadjust with default parameters
im_out_1 = imadjust(im_in);
figure(3);
imshow(im_out_1);
title('Imadjust with Default Parameters');
figure(4);
histo_1 = imhist(im_out_1);
plot(histo_1);
title('Imadjust with Default Parameters');

%Run imadjust with tuned parameters
im_out_2 = imadjust(im_in,[0;.1],[]);
histo_2 = imhist(im_out_2);
figure(5);
imshow(im_out_4);
title('Imadjust with Parameters [0;.1],[]');
figure(6);
plot(histo_4);
title('Imadjust with Parameters [0;.1],[]');

%Run imadjust with tuned parameters
im_out_3 = imadjust(im_in,[0;.1],[0;.75]);
histo_3 = imhist(im_out_3);
figure(7);
imshow(im_out_4);
title('Imadjust with Parameters [0;.1],[0;.75]');
figure(8);
plot(histo_4);
title('Imadjust with Parameters [0;.1],[0;.75]');

%Run imadjust with tuned parameters
im_out_4 = imadjust(im_in,[0;.25],[0;1]);
histo_4 = imhist(im_out_4);
figure(9);
imshow(im_out_4);
title('Imadjust with Parameters [0;.25],[0;1]');
figure(10);
plot(histo_4);
title('Imadjust with Parameters [0;.25],[0;1]');