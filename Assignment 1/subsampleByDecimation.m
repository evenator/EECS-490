function decimated_im = subsampleByDecimation(im_in, factor)
[rows, cols] = size(im_in);
every_other_row = 1:factor:rows;
every_other_col = 1:factor:cols;
decimated_im = im_in;
for i = 1:factor
    decimated_im(every_other_row+i,:)=decimated_im(every_other_row,:);
end
for i = 1:factor
    decimated_im(:,every_other_col+i)=decimated_im(:,every_other_col);
end