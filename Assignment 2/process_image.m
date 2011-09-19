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
    
    %Select Registration Points
    [template_points, image_points] = cpselect(comparison_image, template_image,'Wait',true);
    
    m_warp = [template_points';1,1,1,1]\[image_points';1,1,1,1]
    comparison_image = rgb2gray(comparison_image);
    warped_image = uint8(m_warp*double(comparison_image));
    figure(3)
    image(warped_image);
    title('Warped Image');
    
    return;
    %Load registration points
    reg_points = (xlsread(['point_data/',template_name,'.xls']))';
    for(i = [1:4])
        %Mark a registration point in the template image
        prompt_image = template_image;
        reg_point = reg_points(:,i);
        prompt_image(reg_point,:)% = [255,0,0];
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