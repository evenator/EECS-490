clear all;

%Load Image
im_name = '00889';
im_in = imread(['images/' im_name '.tif']);

% compute the height of each part (just 1/3 of total)
height = floor(size(im_in,1)/3);
width = size(im_in,2);

% separate color channels
im_b = im_in(1:height,:);
im_g = im_in(height+1:height*2,:);
im_r = im_in(height*2+1:height*3,:);

%Display Separated Images
%figure(1);
%imshow(im_b);
%title('Blue Channel');
%figure(2);
%imshow(im_g);
%title('Green Channel');
%figure(3);
%imshow(im_r);
%title('Red Channel');

%Crop edges for processing to avoid distortion
p = .1
crop_b = proportional_crop(im_b, p);
crop_g = proportional_crop(im_g, p);
crop_r = proportional_crop(im_r, p);

%Display Cropped Images
%figure(1);
%imshow(crop_b);
%figure(2);
%imshow(crop_g);
%figure(3);
%imshow(crop_r);

%Perform Edge Detection
edge_b = edge_detect(crop_b);
edge_g = edge_detect(crop_g);
edge_r = edge_detect(crop_r);

%Display Edges
%figure(1);
%imshow(edge_b);
%figure(2);
%imshow(edge_g);
%figure(3);
%imshow(edge_r);

%Find the Image Offsets by Correlation
offset_g = find_offset(crop_b, crop_g)
offset_r = find_offset(crop_b, crop_r)

%Align images
b_align = im_b;
g_align = circshift(im_g, offset_g);
r_align = circshift(im_r, offset_r);

%Display Aligned Images
%figure(1);
%imshow(b_align);
%figure(2);
%imshow(g_align);
%figure(3);
%imshow(r_align);

%Create Color Image
im_color = cat(3, r_align, g_align, b_align);
figure(1);
imshow(im_color);
title('Image Aligned with Cropping');

%Create Comparison Images
im_no_align = cat(3, im_r, im_g, im_b);
figure(2);
imshow(im_no_align);
title('Image Without Alignment');

no_crop_offset_g = find_offset(im_b, im_g)
no_crop_offset_r = find_offset(im_b, im_r)
no_crop_b = im_b;
no_crop_g = circshift(im_g, no_crop_offset_g);
no_crop_r = circshift(im_r, no_crop_offset_r);
im_no_crop_align = cat(3, no_crop_r, no_crop_g, no_crop_b);
figure(3);
imshow(im_no_crop_align);
title('Image Aligned Without Cropping');
