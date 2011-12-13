function [ cap_matrix, mask_image ] = findisolatedcaps( im )
%findisolatedcaps Find the isolated Proctor and Gamble bottle caps.
%   Finds the isolated bottle caps in the input image im. Returns
%   an MATLAB label matrix of the bottle caps in cap_matrix and
%   an output image mask_image with the found caps masked out to
%   simplify later cap-finding operations.

global debug;

%Calibration constants:
min_capsize = 500;
max_capsize = 11000;
erosion_size = 20;

im_size = size(im);

%Initialize the masked image to all ones
mask_image = ones(im_size(1),im_size(2));;

%Initialize the cap matrix to a matrix of zeros the same size as the input
cap_matrix = zeros(im_size(1),im_size(2));

%Perform otsu thresholding on the input image
im_otsu = otsu(im);
im_otsu = ones(im_size(1),im_size(2))-im_otsu;

if debug
    figure(1);
    imshow(im_otsu);
    title('Otsu Thresholded Image');
    pause
end

%Erode the BW image with a large element to sever "bridges"
im_otsu_eroded = erode_im(im_otsu, 'disk', erosion_size);

if debug
    figure(1);
    imshow(im_otsu_eroded);
    title('Eroded Image');
    pause
end

%Find the regions
cc = bwconncomp(im_otsu_eroded);
regions = regionprops(cc,'Area','Centroid');

if debug
    cc
    regions
    for i = 1:length(regions)
        region = regions(i);
        region
    end
    pause
end

%Process the regions
cap_count = 0;
for i = 1:length(regions)
    region = regions(i);
    %Regions in a certain size range are caps
    if region.Area > min_capsize && region.Area < max_capsize
        cap_count = cap_count + 1;
        %For each cap, dilate it back to its original size
        %and then add it to the cap matrix
        region_image = bwselect(im_otsu_eroded,round(region.Centroid(1)),round(region.Centroid(2)),8);
        
        if debug
            figure(1);
            imshow(region_image);
            title('Region Image');
            pause;
        end
        
        dilated_region_image = dilate_im(region_image, 'disk', erosion_size);
        
        if debug
            figure(1);
            imshow(dilated_region_image);
            title('Dilated Region Image');
            pause;
        end
        
        cap_matrix = cap_matrix + cap_count * dilated_region_image;
        %Dilate further with a small element and mask it out of 
        %the masked image
        region_mask = dilate_im(dilated_region_image, 'disk', 5);
        %Mask and invert (mask with white)
        region_mask = region_mask == 0;
        mask_image = mask_image .* double(region_mask);
    end
end