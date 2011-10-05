function [ mtb_im ] = gery2mtb( im_in, bit_depth )
%Converts an input grayscale image to a Median-Threshold-Binary Image

    im_vec = reshape(im_in,1,size(im_in,1)*size(im_in,2));
    mtb_im = im2bw(im_in, double(median(im_vec))/2^bit_depth);


end

