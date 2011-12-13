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
working_image = (mask_image) .* hsv_image(:,:,3) + (mask_image==0)* .9 * graythresh(hsv_image(:,:,3));

[cap_matrix_2] = findgroupedcaps(working_image);
end

