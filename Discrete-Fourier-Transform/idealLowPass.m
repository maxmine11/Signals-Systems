function filtered = idealLowPass(img,factor) 
% idealLowPass applies an ideal low-pass filter for downsampling by a 
% factor of 'factor'to the image img and outputs the filtered image
% 
%
% Inputs:
% img - NxMx3 image of uint8
% factor - downsampling factor that we want to guard against
%
% Output:
% filtered - the filtered image

img = double(img);
[ir,ic,~] = size(img); 
[x, y] = meshgrid(linspace(-pi,pi,ic), linspace(-pi,pi,ir));

% Define your ideal low-pass filter
B=pi/factor;
LF=(x>-B)&(x<B)&(y>-B)&(y<B);
% Apply the filter to each color matrix of your image

I(:,:,1)=fftshift(fft2(img(:,:,1)));
I(:,:,2)=fftshift(fft2(img(:,:,2)));
I(:,:,3)=fftshift(fft2(img(:,:,3)));

LPI(:,:,1)=LF.*I(:,:,1);
LPI(:,:,2)=LF.*I(:,:,2);
LPI(:,:,3)=LF.*I(:,:,3);

IF(:,:,1)=ifft2(ifftshift(LPI(:,:,1)));
IF(:,:,2)=ifft2(ifftshift(LPI(:,:,2)));
IF(:,:,3)=ifft2(ifftshift(LPI(:,:,3)));

filtered=uint8(abs(IF));





% Convert the filtered image to uint8 and return
