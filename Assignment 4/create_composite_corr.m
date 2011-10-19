function [ im_out ] = create_composite_corr( im_r, im_g, im_b )
%Create composite image using correlation of images to find offset
%   Detailed explanation goes here

    %Find the Image Offsets by Correlation
    offset_g = find_offset(im_b, im_g);
    offset_r = find_offset(im_b, im_r);

    %Align images
    b_align = im_b;
    g_align = circshift(im_g, offset_g);
    r_align = circshift(im_r, offset_r);

    %Create Color Image
    im_out = cat(3, r_align, g_align, b_align);
    
    %figure(1);
    %imshow(im_out);
    %title('Image Aligned with No Cropping');

end

