function [ im_out ] = proportional_crop( im_in, p )
%Crops the proportion of the image specified in p from the image im_in
%   Crops all sides of the image.
%   0<p<.5
    [height, width] = size(im_in);
    v_crop = ceil(p*height);
    h_crop = ceil(p*width);
    im_out = im_in(v_crop:height-v_crop,h_crop:width-h_crop);
end

