function [ reconstructed_im ] = reconstruct_im( centroid_c, centroid_r, mask, strel_name, strel_size )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    se = strel(strel_name, strel_size);
    se_im = se.getnhood;
    se_size = size(se_im);
    im_size = size(mask);
    marker = zeros(im_size(1), im_size(2));
    marker_h_bounds = [centroid_c-floor(se_size(2)/2) centroid_c+ceil(se_size(2)/2)-1];
    marker_v_bounds = [centroid_r-floor(se_size(1)/2) centroid_r+ceil(se_size(1)/2)-1];
    marker(marker_v_bounds(1):marker_v_bounds(2),marker_h_bounds(1):marker_h_bounds(2)) = se_im;
    reconstructed_im = imreconstruct(logical(marker), logical(mask));
end

