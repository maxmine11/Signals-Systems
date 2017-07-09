function filtered = meanFilter(img,dim)
% meanFilter applies a mean filter to the image img and outputs the
% filtered image.
%
% Inputs:
% img - NxMx3 image of uint8
% dim - dimension of the mean filter
%
% Output:
% filtered - the filtered image
h=1/(dim^2)*ones(dim);
img(:,:,1)=conv2(img(:,:,1),h,'same');
img(:,:,2)=conv2(img(:,:,2),h,'same');
img(:,:,3)=conv2(img(:,:,3),h,'same');

filtered= img;


