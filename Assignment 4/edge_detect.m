function [ im_edge ] = edge_detect( im_in )
%Performs edge detection using sobel mask and .05 threshold
%   Detailed explanation goes here
    
    im_edge = edge(im_in,'sobel',.04);

end

