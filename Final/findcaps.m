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

%Extract Intensity Plane (Grayscale)
working_image = rgb2gray(input_image);

%Find Isolated Caps
[cap_matrix, masked_image] = findisolatedcaps(working_image);

%Display cap image and masked image
cap_image = label2rgb(cap_matrix, 'jet', 'k', 'shuffle');
figure(2);
imshow(cap_image);
figure(3);
imshow(masked_image);
end

