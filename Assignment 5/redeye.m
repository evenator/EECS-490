%redeye.m
%Author: Edward Venator
%EECS 490, Assignment 5
%Fall 2011
%Performs redeye removal by the method described in Petschnigg et al. and 
%outputs result to output/redeye_result.png

clear all;

%Load and display input images
im_flash = imread('flash.jpg');
im_noflash = imread('noflash.jpg');
figure(1);
imshow([im_flash,im_noflash]);
title('Input Images with Flash (l) and No Flash (r)');

%Convert both images to YCbCr space
im_flash_ycc = rgb2ycbcr(im_flash);
im_noflash_ycc = rgb2ycbcr(im_noflash);

%Compute Difference
im_diff = im_flash_ycc(:,:,3) - im_noflash_ycc(:,:,3);
figure(2);
imshow(im_diff);
title('Cr Difference Between Flash and No-Flash Images');

%Create a Redeye Mask
im_mask = im2bw(im_diff, .12);
figure(3);
imshow(im_mask);
title('Redeye Mask');

%Replace Colors (Patti Method)
[im_height, im_width, ~] = size(im_flash);
mask_inv = ones(im_height, im_width) - im_mask;
im_hsv = rgb2hsv(im_flash);
im_hsv(:,:,2) = im_hsv(:,:,2) .* mask_inv;
im_hsv(:,:,3) = im_hsv(:,:,3) .* (.5 * im_mask + mask_inv);
im_out = hsv2rgb(im_hsv);
figure(4);
imshow(im_out);
title('Redeye-corrected Image');

%Save Image
imwrite(im_out,'output/redeye_result.png','png');