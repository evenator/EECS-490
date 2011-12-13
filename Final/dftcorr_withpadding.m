function g = dftcorr_withpadding(f, w)
%DFTCORR 2-D correlation in the frequency domain.
%   This function from Digital Image Processing USING MATLAB, Second Ed. by
%   Gonzalez, Woods, and Eddins page 491.
%   G = DFTCORR(F, W) performs the correlation of a mask, W, with image F.
%   The output, G, is the correlation image, of class double. The output is
%   of the same size as F. When, as is generally true in practice, the mask
%   image is much smaller than G, wraparound error is negligible if W is
%   padded to size(F).
%   This function has been modified by Edward Venator to include padding

%Pad images
fsize = size(f);
wsize = size(w);
imsize = max(fsize, wsize);
w = padarray(w,floor((imsize-wsize)/2),'replicate','both');
if(sum(size(w)<imsize))
    w = padarray(w,imsize-size(w),'replicate','pre');
end

f = padarray(f,floor((imsize-fsize)/2),'replicate','both');
if(sum(size(f)<imsize))
    size(f)
    f = padarray(f,imsize-size(f),'replicate','pre');
end

M = imsize(1);
N = imsize(2);

f = fft2(f);
w = conj(fft2(w, M, N));
g = real(ifft2(w.*f));