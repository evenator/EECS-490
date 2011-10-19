function [ im_out ] = create_composite_crop( im_r, im_g, im_b )
%Create composite image using correlation of cropped images to find offset
%   Detailed explanation goes here
    
    %Crop edges for processing to avoid distortion
    p = .1;
    crop_b = proportional_crop(im_b, p);
    crop_g = proportional_crop(im_g, p);
    crop_r = proportional_crop(im_r, p);

    %Find the Image Offsets by Correlation
    offset_g = find_offset(crop_b, crop_g);
    offset_r = find_offset(crop_b, crop_r);

    %Align images
    b_align = im_b;
    g_align = circshift(im_g, offset_g);
    r_align = circshift(im_r, offset_r);

    %Create Color Image
    im_out = cat(3, r_align, g_align, b_align);
    
    %figure(1);
    %imshow(im_out);
    %title('Image Aligned with Cropping');

end

