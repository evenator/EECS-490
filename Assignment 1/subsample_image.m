im = imread('test.jpg','jpg');
im = rgb2gray(im);
[rows, cols] = size(im)
im_out = mat2gray(zeros(512,512));
color_depth = 512
factor = 512/color_depth
for row = 1:rows
    for col = 1:cols
        im_out(row,col) = im(row,col);%floor(im(row,col)/factor);
    end
end
figure
imshow(im)
figure
imshow(im_out)