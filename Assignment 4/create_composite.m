function [ im_out ] = create_composite( im_r, im_g, im_b )
%Create a composite image from r, g, and b planes im_r, im_g, im_b
%   Detailed explanation goes here

    im_out = cat(3, im_r, im_g, im_b);
    
    %imshow(im_out);
    %title('Image with No Alignment');


end