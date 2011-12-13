function [ dist_im1, distim2, cap_matrix ] = findgroupedcaps( im )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global debug;

[A, eigenspace_templates, mean_vec] = createeigentemplate(2);
im_size = size(im);
cap_matrix = [];

if debug
    figure(5);
    imshow(im);
    title('Image');
    pause
end

%Perform otsu thresholding on the input image
im_otsu = otsu(im);
im_otsu = ones(im_size(1),im_size(2))-im_otsu;

if debug
    figure(6);
    clf;
    imshow(im_otsu);
    title('Otsu Thresholded Image');
    pause
end

%Find the regions to use as ROI (want any clusters of caps)
cc = bwconncomp(im_otsu);
regions = regionprops(cc,'BoundingBox');


if debug
    cc
    regions
    pause
end

%Move a 150px square window through the region and return the distance as
%computed using PCA
cap_count = 0;
length(regions);

debug =1;
if(debug)
    counter = 0;
    tic;
end
dist_im1 = zeros(im_size(1),im_size(2));
dist_im2 = zeros(im_size(1),im_size(2));
for i = 1:length(regions)
    region = regions(i);
    ul_corner = ceil([region.BoundingBox(2), region.BoundingBox(1)]);
    lr_corner = floor([region.BoundingBox(2), region.BoundingBox(1)] + [region.BoundingBox(4), region.BoundingBox(3)]);
    flag = 0;
    for row = max(1,ul_corner(1)-50):(min(im_size(1),lr_corner(1)+50)-149)
        for col = max(1,ul_corner(2)-50):(min(im_size(2),lr_corner(2)+50)-149)
            counter = counter +1;
            window_img = im_otsu(row:(row+149),col:(col+149));
            window_vec = reshape(window_img,[],1);
            window_vec = window_vec - mean_vec;
            window_eig = A * window_vec;
            diff_mat = ones(size(eigenspace_templates,1),1) * window_eig' - eigenspace_templates;
            dist_vec = sum(diff_mat .* diff_mat,2);
            min_dist = min(dist_vec);
            max_dist = max(dist_vec);
            dist_im1(row+75, col+75) = min_dist;
            dist_im2(row+75, col+75) = max_dist;
        end
    end
end

if debug
    figure(7);
    clf;
    imshow(dist_im);
    toc
    counter
end

figure(7)
debug = 0;

