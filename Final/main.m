clear all;

%Load Image 1
im1 = imread('im1_scaled.jpg');
im1 = imadjust(rgb2gray(im1));

%Find centroids and label matrix of caps
[centroids1, capmat1] = capcentroids(im1);

%Display Centroids
figure(1);
clf;
imshow(im1);
hold on;
plot(centroids1(:,1),centroids1(:,2), 'b*');
hold off;

%Display Labels
cap_image1 = label2rgb(capmat1, 'jet', 'k', 'shuffle');
figure(4);
imshow(cap_image1);
imwrite(cap_image1,'im1_results.png');

%Load Image 2
im2 = imread('im2_scaled.jpg');
im2 = imadjust(rgb2gray(im2));

%Find centroids and label matrix of caps
[centroids2, capmat2] = capcentroids(im2);

figure(2);
clf;
imshow(im2);
hold on;
plot(centroids2(:,1),centroids2(:,2), 'b*');
hold off;

%Display Labels
cap_image2 = label2rgb(capmat2, 'jet', 'k', 'shuffle');
figure(5);
imshow(cap_image2);
imwrite(cap_image2,'im2_results.png');

global debug
%debug = 1;

%Load Image 3
im3 = imread('im3_cropped.jpg');
im3 = imadjust(rgb2gray(im3));
%Find centroids and label matrix of caps
[centroids3, capmat3] = capcentroids(im3);

figure(3);
clf;
imshow(im3);
hold on;
plot(centroids3(:,1),centroids3(:,2), 'b*');
hold off;

%Display Labels
cap_image3 = label2rgb(capmat3, 'jet', 'k', 'shuffle');
figure(6);
imshow(cap_image3);
imwrite(cap_image3,'im3_results.png');

debug = 0;