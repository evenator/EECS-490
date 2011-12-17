im_in = imread('im2_scaled.jpg');

im_size = size(im_in);

fig_num = 1;

debug = 1;

if(debug)
    figure(fig_num); fig_num = fig_num+1;
    imshow(im_in);
end

im_otsu = otsu(im_in);

if(debug)
    figure(fig_num); fig_num = fig_num+1;
    imshow(im_otsu);
end

im_otsu_dilated = dilate_im(im_otsu, 'disk', 6);

if(debug)
    figure(fig_num); fig_num = fig_num+1;
    imshow(im_otsu_dilated);
end

N=50;

if(debug)
    figure(fig_num); fig_num = fig_num+1;
end

working_image = im_otsu_dilated;
thresh = 20000;
centroids = [0 0];
warning off all;
i = 1;

debug = 0;

while i<=N
    i_next = i + 1;
    %Erode the working image by 2*i
    eroded_image = erode_im(working_image,'disk',2*i);
    if debug
        figure(3);
        imshow(working_image);
        figure(fig_num-1);
        imshow(eroded_image);
    end
    %Update the size threshold
    cur_thresh = thresh - i*600;
    %Get the list of connected regions
    cc = bwconncomp(eroded_image);
    regions = regionprops(cc,'Area','Centroid');
    if(length(regions)==0)
        break; %No regions, so we're done
    end
    %Find all regions smaller than the threshold for a cap
    regionIDs = find([regions.Area] < cur_thresh);
    for j = regionIDs
        %Mask these regions out of the working image (dilate masks to original
        %size)
        mask = ismember(labelmatrix(cc), j);
        mask = dilate_im(mask,'disk',2*i);
        mask = ~mask;
        working_image = mask .* working_image;
        %If the region is large enough to be a cap, add its centroid to the
        %list of caps
        if regions(j).Area > 1000
            centroids = [centroids; regions(j).Centroid];
            i_next = 0;
        end
    end
    if debug
        figure(fig_num-1);
        hold on
        plot(centroids(:,1),centroids(:,2), 'b*');
        hold off;
        pause;
    end
    i = i_next;
end

debug = 1;

if debug
    figure(1);
    hold on;
    plot(centroids(:,1),centroids(:,2), 'b*');
    hold off;
end