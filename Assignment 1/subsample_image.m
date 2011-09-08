clear;

%Load image
load_image

%Number of resized images to create
num_imgs = 5;

%Subsample by Nearest Neighbor
%Create an output canvas
img_out_nn = zeros(rows, (num_imgs+1) * cols);
for i = 0:num_imgs
    temp = imresize(img_in, .5^i, 'nearest');
    left_bound = i*cols + 1;
    right_bound = (i+1)*cols;
    img_out_nn(:,left_bound:right_bound) = imresize(temp, 2^i, 'nearest');
end
img_out_nn = mat2gray(img_out_nn);
figure(2)
imshow(img_out_nn)
truesize;
title('Resized by Nearest Neighbor');

%Subsample Bileaner
%Create an output canvas
img_out_bl = zeros(rows, (num_imgs+1) * cols);
for i = 0:num_imgs
    temp = imresize(img_in, .5^i, 'bilinear');
    left_bound = i*cols + 1;
    right_bound = (i+1)*cols;
    img_out_bl(:,left_bound:right_bound) = imresize(temp, 2^i, 'bilinear');
end
img_out_bl = mat2gray(img_out_bl);
figure(3)
imshow(img_out_bl)
truesize;
title('Resized by Bilinear Method');

%Subsample Bicubic
%Create an output canvas
img_out_bc = zeros(rows, (num_imgs+1) * cols);
for i = 0:num_imgs
    temp = imresize(img_in, .5^i, 'bicubic');
    left_bound = i*cols + 1;
    right_bound = (i+1)*cols;
    img_out_bc(:,left_bound:right_bound) = imresize(temp, 2^i, 'bicubic');
end
img_out_bc = mat2gray(img_out_bc);
figure(4)
imshow(img_out_bc)
truesize;
title('Resized by Bicubic Method');
