function [ offset ] = find_offset( im1, im2 )
%Finds the translational offset of im1 from im2 that maximizes the
%correlation
    corr = dftcorr(im1, im2);
    
    %Rescale the correlation for display
    %dispcorr = (corr-min(min(corr)))/(max(max(corr))-min(min(corr)));
    %imshow(dispcorr);
       
    %Find the maximum of the correlation and return its col number
    [~, col_offset] = max(max(corr));
    [~, row_offset] = max(corr(:, col_offset));
    if(row_offset>size(corr,1)/2)
        row_offset = row_offset-size(corr,1);
    end
    if(col_offset>size(corr,2)/2)
        col_offset = col_offset-size(corr,2);
    end
    offset = [row_offset, col_offset];
end

