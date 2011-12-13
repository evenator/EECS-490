function [ cap_matrix ] = findcaps( filename )
%FINDCAPS Finds the Proctor and Gamble Bottle Caps
%   Loads the image described by the filename string,
%   then finds the bottle caps found in the image. Returns
%   an MATLAB label matrix of the bottle caps

%Load Image
input_image = imread(filename);

%Show Input Image
figure(1);
imshow(input_image);

%Extract Saturation Plane (Grayscale)
hsv_image = rgb2hsv(input_image);
working_image = hsv_image(:,:,2);

%Find Isolated Caps
[cap_matrix, mask_image] = findisolatedcaps(working_image);

%Display cap image and masked image
cap_image = label2rgb(cap_matrix, 'jet', 'k', 'shuffle');
figure(2);
imshow(cap_image);
figure(3);
imshow(mask_image);

%Mask Out the found caps
masked_image_r = double(input_image(:,:,1))/255 .* mask_image;
masked_image_g = double(input_image(:,:,2))/255 .* mask_image;
masked_image_b = double(input_image(:,:,3))/255 .* mask_image;
masked_image = cat(3, masked_image_r, masked_image_g, masked_image_b);
figure(4);
imshow(masked_image);
end

