function [ centroids,labelmat ] = capcentroids( im_in )
%Processes the image im_in and returns a list of the centroids of the
%bottle caps it finds.

global debug;
%BEGIN PARAMETERS (TUNABLE)

%Number of times to erode the image before giving up (will stop early if
%all caps are found)
N=50;
%Maximum size threshold for a cap
thresh = 21000;
%Minimum size threshold for a cap
minthresh = 10000;
%Amount to decrement the thresholds
threshdec = 600;

%END PARAMETERS

%Initialize Figure Number
fig_num = 1;

%If in debug mode, display image
if(debug)
    figure(fig_num); fig_num = fig_num+1;
    imshow(im_in);
end

%Perform otsu thresholding on the input image
im_otsu = otsu(im_in);

%If in debug mode, display the thresholded image
if(debug)
    figure(fig_num); fig_num = fig_num+1;
    imshow(im_otsu);
end

%Dilate the image to remove noise and close holes in the caps
im_otsu_dilated = dilate_im(im_otsu, 'disk', 6);

%If in debug mode, show the dilated image
if(debug)
    figure(fig_num); fig_num = fig_num+1;
    imshow(im_otsu_dilated);
end


%Prepare a figure if in debug mode
if(debug)
    figure(fig_num); fig_num = fig_num+1;
end

%Use the dilated image as the working image
working_image = im_otsu_dilated;

%Initialize the list of centroids
centroids = [];

%Initialize a label matrix
im_size = size(working_image);
labelmat = zeros(im_size(1),im_size(2));

%Start the counter at 1 (can't use a for loop because we reset this
%sometimes)
i = 1;
while i<=N
    i_next = i + 1; %Increment counter
    
    %Erode the working image by 2*i
    eroded_image = erode_im(working_image,'disk',2*i);
    
    %If in debug mode, display the current working image and the eroded
    %image
    if debug
        figure(fig_num-2);
        imshow(working_image);
        figure(fig_num-1);
        imshow(eroded_image);
    end
    
    %Update the size threshold (shrink it as you erode more)
    cur_thresh = thresh - i*threshdec;
    
    %Get the list of connected regions
    cc = bwconncomp(eroded_image);
    regions = regionprops(cc,'Area','Centroid');
    
    %If no regions are found, end search
    if(isempty(regions))
        break; %No regions, so we're done
    end
    
    %Find all regions smaller than the threshold for a cap
    regionIDs = find([regions.Area] < cur_thresh);
    
    %Process the regions small enough to be caps/noise
    for j = regionIDs
        %Mask these regions out of the working image (dilate masks to original
        %size)
        mask = ismember(labelmatrix(cc), j);
        mask = dilate_im(mask,'disk',2*i);
        mask = ~mask;
        working_image = mask .* working_image;
        %If the region is large enough to be a cap, add its centroid to the
        %list of caps and add its mask to the label matrix
        if regions(j).Area > (minthresh - i*threshdec)
            centroids = [centroids; regions(j).Centroid];
            labelnum = max(max(labelmat))+1;
            %Give already found object precedence over newly found
            labelmat = labelmat + (labelmat==0) .* ~mask * labelnum;
            i_next = 0;
        end
    end
    
    %If in debug mode, plot the current centroids on working image
    if debug
        figure(fig_num-1);
        hold on
        if(size(centroids,1)>0)
            plot(centroids(:,1),centroids(:,2), 'b*');
        end
        hold off;
        pause;
    end
    i = i_next;
end

%If in debug mode, plot the centroids on the color image
if debug
    figure(1);
    hold on;
    plot(centroids(:,1),centroids(:,2), 'b*');
    hold off;
end

end

