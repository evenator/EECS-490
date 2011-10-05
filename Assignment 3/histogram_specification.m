%Load the image
im_in = imread('phobos_X.tif');
[im_rows, im_cols] = size(im_in);
figure(1);
imshow(im_in);
title('Input Image');

%Show histogram
histo_in = imhist(im_in);
figure(2);
plot(histo_in);
title('Input Image Histogram');

%Compute Some Statistical Nonsense
histo_norm = histo_in / sum(histo_in);
figure(3);
plot(histo_norm);
title('Normalized Histogram');
T = zeros(length(histo_norm));
for i = 1:length(histo_norm)
    T(i) = 255 * sum(histo_norm(1:i));
end
figure(4);
plot(T);
title('CDF');

%Set Up Desired Histogram CDF
%Histogram defined by piecewise function (taken from GW pg 138)
%hist_des = ???;
hist_des(1:4) = 0:(7/3):7;
hist_des(4:16) = 7:(-49/8/12):7/8;
hist_des(16:180) = 7/8:(-7/8/164):0;
hist_des(180:208) = 0:3/4/28:3/4;
hist_des(208:255) = 3/4:-3/4/47:0;
figure(5);
plot(hist_des);
title('Desired Histogram');
pdf_des = hist_des / sum(hist_des);
G = zeros(length(pdf_des));
for i = 1:length(pdf_des)
    G(i) = 255 * sum(pdf_des(1:i));
end
figure(6);
plot(G);
title('Desired Histogram CDF');

%Match Histograms
im_out = im_in;
for row = 1:im_rows
    for col = 1:im_cols
        val_in = im_in(row, col);
        CDF_in = T(val_in + 1);
        %Find this in the output CDF and get the value
        old_diff = abs(G(1) - CDF_in);
        for i = 2:length(G)
            diff = abs(G(i) - CDF_in);
            if diff > old_diff
                val_out = i-2;
                break;
            end
            old_diff = diff;
            val_out = i-1;
        end
        im_out(row, col) = val_out;
    end
end
figure(7);
imshow(im_out);
title('Transformed Image');
figure(8);
hist_out = imhist(im_out);
plot(hist_out);
title('Output Histogram');