% This code loosely based on Face recognition by Santiago Serrano
% http://www.pages.drexel.edu/~sis26/Eigenface%20Tutorial.htm

%Tunable Parameters
M = 27; %Number of images in training set
img_h = 150; %Image size
img_w = 150; %Image size

%Load in all images and show them

%Img set S
S = zeros(img_h*img_w, M);
figure(1);
for i=1:M
    img_in = imread(['cap_templates/cap' int2str(i) '.jpg']);
    img = rgb2gray(img_in);
    subplot(ceil(sqrt(M)),ceil(sqrt(M)),i)
    imshow(img)
    if i==3
        title('Training set','fontsize',18)
    end
    drawnow;
    img_vec = reshape(img,[],1); %Reshape image into a vector
    S(:,i) = img_vec; %Insert image vector into the image set
end

%Normalize images
des_mean = mean(mean(S));
des_std = mean(std(S));
%Todo: use matrices here to make it faster
for i=1:size(S,2)
    img_vec = double(S(:,i));
    img_mean=mean(img_vec);
    img_std=std(img_vec);
    S(:,i)=((img_vec-img_mean)*des_std/img_std+des_mean)/255;
end

%Display Normalized Images
figure(2);
for i=1:M
    img=reshape(S(:,i),img_w,img_h);
    subplot(ceil(sqrt(M)),ceil(sqrt(M)),i)
    imshow(img)
    drawnow;
    if i==3
        title('Normalized Training Set','fontsize',18)
    end
end

%Create Mean Image
mean_img_vec = mean(S,2);
mean_img = reshape(mean_img_vec,img_w,img_h);
figure(3);
imshow(img);
title('Mean Image','fontsize',18)

%Subtract Mean Image from Image Set
%Todo: use matrices here to make it faster
for i=1:M
S(:,i) = S(:,i) - mean_img_vec;
end

dbx = S;
icol = img_w;
irow = img_h;


%Covariance matrix C is way too large to deal with, but Q matrix is
%manageable
Q = S' * S;

%Generate eigenvalues
[q_eig_vectors eigenvalues] = eig(Q);
vv = q_eig_vectors;
dd = eigenvalues;

%This code needs to be reverse engineered and improved, because as written
%it's (c) Santiago
% Sort and eliminate those whose eigenvalue is zero
v=[];
d=[];
for i=1:size(vv,2)
    if(dd(i,i)>1e-4)
        v=[v vv(:,i)];
        d=[d dd(i,i)];
    end
end

%sort, will return an ascending sequence
[B index]=sort(d);
ind=zeros(size(index));
dtemp=zeros(size(index));
vtemp=zeros(size(v));
len=length(index);
for i=1:len
    dtemp(i)=B(len+1-i);
    ind(i)=len+1-index(i);
    vtemp(:,ind(i))=v(:,i);
end
d=dtemp
v=vtemp;

%End Santiago Code

q_eig_vectors = v;
eigenvalues = d;

%Normalize eigenvectors of Q
for i=1:size(q_eig_vectors,2)
    eig_vec = q_eig_vectors(:,i);
    q_eig_vectors(:,i) = eig_vec ./ sqrt(sum(eig_vec .^ 2));
end

%Eigenvectors of C matrix
eigenvectors = zeros(img_h*img_w, size(q_eig_vectors,2));
for i=1:size(eigenvectors,2)
    eigenvectors(:,i) = (S * q_eig_vectors(:,i)) ./ sqrt(eigenvalues(i));
end

%Normalize eigenvectors
for i=1:size(eigenvectors,2)
    eigenvector = eigenvectors(:,i);
    eigenvectors(:,i) = eigenvector ./ sqrt(sum(eigenvector .^ 2));
end

%Show Eigencaps
figure(4);
for i=1:size(eigenvectors,2)
    img=reshape(eigenvectors(:,i),img_h,img_w);
    img=histeq(img,255);
    subplot(ceil(sqrt(M)),ceil(sqrt(M)),i)
    imshow(img)
    drawnow;
    if i==3
        title('Eigencaps','fontsize',18)
    end
end