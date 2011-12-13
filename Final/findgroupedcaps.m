function [ cap_matrix ] = findgroupedcaps( im )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global debug;

%Tunable Parameters
erosion_size = 15;
min_cap_size = 4000;
region_expansion = 50;
num_templates = 27;
template_size = [150 150];
hsv_channel = 3;
corr_thresh = 2e+4;
%End Tunable Parameters

im_size = size(im);
cap_matrix = [];

debug =1;
if debug
    figure(5);
    imshow(im);
    title('Image');
    pause
end

%Load Comparison Templates
templates = zeros([template_size num_templates]);
figure(1);
for i=1:num_templates
    img_in = imread(['cap_templates/cap' int2str(i) '.jpg']);
    img_in = rgb2hsv(img_in);
    img = img_in(:,:,hsv_channel);
    templates(:,:,i) = img; %Insert image vector into the image set
end

%Perform otsu thresholding on the input image
im_otsu = otsu(ones(im_size)-im);
im_otsu = ones(im_size(1),im_size(2))-im_otsu;

if debug
    figure(6);
    clf;
    imshow(im_otsu);
    title('Otsu Thresholded Image');
    pause
end


%Erode the BW image with a medium-sized element to sever "bridges"
im_otsu_eroded = erode_im(im_otsu, 'disk', erosion_size);

if debug
    figure(7);
    imshow(im_otsu_eroded);
    title('Eroded Image');
    pause
end

%Find the regions to use as ROI (want any clusters of caps)
cc = bwconncomp(im_otsu_eroded);
regions = regionprops(cc,'Area', 'BoundingBox');

%Move a 150px square window through the region and return the distance as
%computed using PCA
cap_count = 0;
for i = 1:length(regions)
    region = regions(i);
    if(region.Area>min_cap_size)
        %Pull Out Region of Interest
        ul_corner = ceil([region.BoundingBox(2), region.BoundingBox(1)]);
        lr_corner = floor([region.BoundingBox(2), region.BoundingBox(1)] + [region.BoundingBox(4), region.BoundingBox(3)]);
        ul_corner = [max(1,ul_corner(1)-region_expansion), max(1,ul_corner(2)-region_expansion)];
        lr_corner = [min(im_size(1),lr_corner(1)+region_expansion), min(im_size(2),lr_corner(2)+region_expansion)];
        roi = im(ul_corner(1):lr_corner(1),ul_corner(2):lr_corner(2));
        if debug
            region.Area
            figure(8)
            imshow(roi);
            pause
        end
        %Go through templates, performing correllation
        for i= 1:num_templates
            template = templates(:,:,i);
            corr_im = dftcorr_withpadding(template, roi);
            max_corr = max(max(corr_im));
            if debug
                figure(9);
                imshow(template);
                figure(10);
                corr_bw = corr_im>corr_thresh;
                imshow(corr_bw);
                max_corr
                pause;
            end
        end
    end
end
debug = 0;

