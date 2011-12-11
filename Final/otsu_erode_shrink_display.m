name = 'im3';

I = imread([name '_otsu.png']);
figure(3);
imshow(I);
se = strel('disk',10);
I_eroded = imerode(I,se);
figure(4);
imshow(I_eroded);

name_eroded = [name '_otsu_eroded'];
I = I_eroded;
I_points = bwmorph(I,'shrink',Inf);
figure(5);
I_big_points = bwmorph(I_points,'dilate',10);
imshow(I_big_points);
num_objects = sum(sum(I_points))

I = imread([name '.jpg']);
I_gray = rgb2gray(I);
red_layer = double(I_gray) + 100*double(I_big_points);
green_layer = I_gray;
blue_layer = I_gray;
I_disp = cat(3,red_layer,green_layer,blue_layer);
figure(6);
imshow(I_disp);