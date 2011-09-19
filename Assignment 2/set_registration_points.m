%For each image:
function registration_points = set_registration_points(template_name)
    %Load Template Image
    template_image = imread(['pics/',template_name,'.bmp']);
    figure(1)
    image(template_image);
    title('Template Image');
    
    %Have the user specify four registration points
    disp('Please Choose 4 Registration Points on the Image')
    registration_points = ginput(4);
    %Save the points to a file
    registration_points = round(registration_points);
    xlswrite(['point_data/',template_name,'.xls'],registration_points);
end