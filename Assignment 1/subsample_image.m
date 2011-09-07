%Load image
im = imread('test.jpg','jpg');
im = rgb2gray(im);
[rows, cols] = size(im);
figure(1)
imshow(im)
truesize;
title('Original Image')

%Decimate Image
decimated_im = im;
decimated_im = subsampleByDecimation(decimated_im,4);
figure(2)
imshow(decimated_im)
truesize;
title('Decimated Image')

break
%Average Pixels
averaged_im = im;
averaged_im(every_other_row+1,:)=uint8((double(im(every_other_row,:))+double(im(every_other_row+1,:)))/2);
averaged_im(every_other_row,:)=uint8((double(im(every_other_row,:))+double(im(every_other_row+1,:)))/2);
averaged_im(:,every_other_col+1)=uint8((double(im(:,every_other_col))+double(im(:,every_other_col+1)))/2);
averaged_im(:,every_other_col)=uint8((double(im(:,every_other_col))+double(im(:,every_other_col+1)))/2);
figure(3)
imshow(averaged_im)
truesize;
title('Averaged Image')