name = 'im3';
I = imread([name '.jpg']);
figure(1);
imshow(I);
I_grey = rgb2gray(I);
figure(2);
imshow(I_grey);

h = fspecial('laplacian');
I_laplacian = imfilter(I_grey,h);
figure(4);
imshow(I_laplacian)

h = fspecial('average',[8 8]);
I_smooth = imfilter(I_laplacian,h);
figure(3);
imshow(I_smooth)

m_watershed = watershed(I_laplacian);
I_watershed = label2rgb(m_watershed,'jet',[.5 .5 .5]);
figure(5);
imshow(I_watershed)