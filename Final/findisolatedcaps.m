function [ cap_matrix, masked_image ] = findisolatedcaps( im )
%findisolatedcaps Find the isolated Proctor and Gamble bottle caps.
%   Finds the isolated bottle caps in the input image im. Returns
%   an MATLAB label matrix of the bottle caps in cap_matrix and
%   an output image mask_image with the found caps masked out to
%   simplify later cap-finding operations.

global debug;

%Calibration constants:
min_capsize = 20;
max_capsize = 2400;

%Initialize the masked image to equal the input image
masked_image = im;

%Initialize the cap matrix to a matrix of zeros the same size as the input
im_size = size(im);
cap_matrix = zeros(im_size(1),im_size(2));

%Perform otsu thresholding on the input image
im_otsu = otsu(im);

if debug
    figure(1);
    imshow(im_otsu);
    title('Otsu Thresholded Image');
    pause
end

%Erode the BW image with a large element to sever "bridges"
im_otsu_eroded = erode_im(im_otsu, 'disk', 30);

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
        %For each cap, reconstruct it back to its original size
        %and then add it to the cap matrix
        region_image = bwselect(im_otsu_eroded,round(region.Centroid(1)),round(region.Centroid(2)),8);
        
        if debug
            figure(1);
            imshow(region_image);
            title('Region Image');
            pause;
        end
        
        dilated_region_image = dilate_im(region_image, 'disk', 30);
        
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
        %Invert to create a mask
        region_mask = region_mask == 0;
        masked_image = region_mask .* double(masked_image);
    end
end