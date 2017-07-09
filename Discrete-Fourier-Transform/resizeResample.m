function resampled = resizeResample(img,factor)

% resizeResample reduces the size of an image by just subsampling it by a
% factor of variable 'factor'
%
% Inputs:
% img - NxMx3 matrix of uint8, image
% factor - factor by which you should downsample img
%
% Output:
% resampled - floor(N/factor)xfloor(M/factor)x3 matrix of uint8
%               representing downsampled image
resampled = img(1:factor:end,1:factor:end,:);