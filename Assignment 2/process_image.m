%For each image:
function processed_image = process_image(template_name, image_name)
    %Load Template Image
    template_image = imread(['pics/',template_name,'.bmp']);
    figure(1)
    image(template_image);
    title('Template Image');
    template_size = size(template_image);
    
    %Load input Image
    input_image = imread(['pics/',image_name,'.jpg']);
    figure(2)
    image(input_image);
    title('Input Image');
    
    %Select Registration Points
    %[template_points, image_points] = cpselect(input_image, template_image,'Wait',true);
    %save('registration_points','template_points','image_points');
    load('registration_points','template_points','image_points');
    
    %Create transform object
    transform = cp2tform(template_points, image_points,'affine');
    
    %Transform Image
    transformed_image = imtransform(input_image, transform, 'bilinear','Size',template_size);
    figure(3)
    image(transformed_image)
    title('Transformed Image')
    
    %Put both images in grayscale
    transformed_image = rgb2gray(transformed_image);
    imshow(transformed_image);
    template_image = rgb2gray(template_image);
    truesize();
    figure(1)
    imshow(template_image);
    truesize();
    
    %Subtract images and display
    
end