clear;

%Load image
load_image

%Number of resized images to create
num_imgs = 7;

%Create blank canvas
pyramid = 255*ones(rows,cols*1.5);

pyramid(:,1:cols)=img_in;

top_bound = 1;
left_bound = cols;
%Subsample Bicubic
for i = 1:num_imgs
    temp = imresize(img_in, .5^i, 'bicubic');
    [temp_rows, temp_cols] = size(temp);
    right_bound = left_bound+temp_cols-1;
    bottom_bound = top_bound+temp_rows-1;
    pyramid(top_bound:bottom_bound,left_bound:right_bound) = temp;
    top_bound = bottom_bound+1;
end

pyramid=mat2gray(pyramid);
figure(2);
imshow(pyramid);
title('Image pyramid');