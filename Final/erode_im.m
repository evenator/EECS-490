function [ eroded_im ] = erode_im( im, strel_name, strel_size )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    se = strel(strel_name, strel_size);
    eroded_im = imerode(im,se);

end

