function [ im_edge_align ] = create_composite_edge( im_r, im_g, im_b )
%Create a composite image from r, g, and b planes im_r, im_g, im_b
%   Detailed explanation goes here

    %Crop edges for processing to avoid distortion
    p = .1;
    crop_b = proportional_crop(im_b, p);
    crop_g = proportional_crop(im_g, p);
    crop_r = proportional_crop(im_r, p);

    %Do edge detection to discard value
    edge_b = edge_detect(crop_b);
    edge_g = edge_detect(crop_g);
    edge_r = edge_detect(crop_r);
    
    %Calculate Offsets
    edge_offset_g = find_offset(edge_b, edge_g);
    edge_offset_r = find_offset(edge_b, edge_r);
    
    %Create aligned images
    edge_align_b = im_b;
    edge_align_g = circshift(im_g, edge_offset_g);
    edge_align_r = circshift(im_r, edge_offset_r);
    im_edge_align = cat(3, edge_align_r, edge_align_g, edge_align_b);
    %imshow(im_edge_align);
    %title('Image Aligned with Cropping and Edge Detection');


end

