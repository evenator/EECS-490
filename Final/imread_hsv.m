function [ im_hsv ] = imread_hsv( name )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    im = imread(name);
    im_hsv = rgb2hsv(im);

end

