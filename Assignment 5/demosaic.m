%demosaic.m
%Author: Edward Venator
%EECS 490, Assignment 5
%Fall 2011
%Performs demosaicking of Bayer pattern in bayerimg.mat by linear
%interpolation and outputs result to output/demosaic_result.png

clear all;

%Load and display input image
load bayerimg.mat;
figure(1);
imshow(bayerimg);
title('Input Bayer Image');
[im_height, im_width] = size(bayerimg);

%Create Color Masks
r_mask = uint8(mod(1:im_height,2)' * mod(1:im_width,2));
b_mask = circshift(r_mask, [1,1]);
g_mask = circshift(r_mask, [1,0]) + circshift(r_mask, [0,1]);

%Basic Color Image (No interpolation)
color_im = cat(3, r_mask .* bayerimg, g_mask .* bayerimg, b_mask .* bayerimg);
figure(2);
imshow(color_im);
title('Color Image Before Demosaicing');

%Perform Interpolation
r_kernel = [
    1,2,1;
    0,4,0;
    1,2,1]/4;
r_channel = uint8(imfilter(double(color_im(:,:,1)), r_kernel));

g_kernel = [
    0,1,0;
    1,4,1;
    0,1,0]/4;
g_channel = uint8(imfilter(double(color_im(:,:,2)), g_kernel));

b_kernel = [
    1,0,1;
    2,4,2
    1,0,1]/4;
b_channel = uint8(imfilter(double(color_im(:,:,3)), b_kernel));

%Combine Channels
im_out = cat(3,r_channel, g_channel, b_channel);
figure(3);
imshow(im_out);
title('Color Image After Bilinear Demosaicing');

%Save Image
imwrite(im_out,'output/demosaic_result.png','png');
