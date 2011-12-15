clear all;

%Load Image
im_name = '00889';
im_in = imread(['images/' im_name '.tif']);
tic();
% compute the height of each part (just 1/3 of total)
height = floor(size(im_in,1)/3);
width = size(im_in,2);

% separate color channels
im_b = im_in(1:height,:);
im_g = im_in(height+1:height*2,:);
im_r = im_in(height*2+1:height*3,:);

%Create Output Images
%im_color = create_composite(im_r, im_g, im_b);
%im_color_corr = create_composite_corr(im_r, im_g, im_b);
%figure(1)
im_color_crop = create_composite_crop(im_r, im_g, im_b);
%figure(2)
%im_color_edge = create_composite_edge(im_r, im_g, im_b);
toc()
%imwrite(im_color_crop,['images/',im_name,'_output','.png']);