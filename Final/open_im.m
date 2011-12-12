function [ opened_im ] = open_im( im, strel_name, strel_size )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    se = strel(strel_name, strel_size);
    opened_im = imopen(im,se);

end

