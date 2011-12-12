function [ im_bw ] = otsu( im )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    thresh = graythresh(im);
    im_bw = im2bw(im,thresh);

end

