%For each image:
function processed_image = process_image(template_name, image_name)
    %Load Template Image
    template_image = imread(['pics/',template_name,'.bmp']);
    figure(1)
    image(template_image);
    title('Template Image');
    
    %Load comparison Image
    comparison_image = imread(['pics/',image_name,'.jpg']);
    figure(2)
    image(comparison_image);
    title('Comparison Image');
    
    %Load registration points
    reg_points = (xlsread(['point_data/',template_name,'.xls']))';
    for(reg_point = reg_points)
        %Mark a registration point in the template image
        prompt_image = template_image;
        prompt_image(reg_point)
        prompt_image(reg_point)=[255,0,0];
        figure(1)
        image(prompt_image);
        title('Click the corresponding point in the other image');
        %Prompt user to click point in comparison image
        figure(2)
        title('Click the corresponding point');
        point = ginput(1)
    end
    
    %Compute warp matrix

    %Perform warp and display warped image

    %Put both images in greyscale

    %Subtract images and display
    
end