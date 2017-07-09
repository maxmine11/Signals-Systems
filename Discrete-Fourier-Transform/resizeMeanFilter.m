function resampled = resizeMeanFilter(img,factor)

% resizeMeanFilter reduces the size of an image by filtering it with a mean
% filter and then subsampling it by a factor of variable 'factor'
%
% Inputs:
% img - NxMx3 matrix of uint8, image
% factor - factor by which you should downsample img
%
% Output:
% resampled - floor(N/factor)xfloor(M/factor)x3 matrix of uint8
%               representing downsampled image

filtered = meanFilter(img,factor);
resampled = resizeResample(filtered,factor);