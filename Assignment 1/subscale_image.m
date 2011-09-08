clear;

%Load image
load_image;

num_imgs=8;

%Create an output canvas
img_out = zeros(rows, (num_imgs+1) * cols);
for i = 0:num_imgs
    temp = round(double(img_in)*.5^i)*2^i;
    left_bound = i*cols + 1;
    right_bound = (i+1)*cols;
    img_out(:,left_bound:right_bound) = uint8(temp);
end
img_out = mat2gray(img_out);
figure(2)
imshow(img_out)
truesize;
title('Progressively Decreasing Grayscale');
imwrite(img_out,'img_out_grays.png','png');