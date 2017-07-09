close all 
clear all
%% 1) Generate a random image
% TODO create the colormap. Remember that colormap defines color values 
% using numbers in the range [0,1], not [0, 255]
cmap=[];
for i = 1:256
    for j = 1:3
        cmap(i,j)=i-1;
    end
end 
cmap=cmap/255
randImg=randi([0 255],200,200)


    

% TODO create an image of random integers in the range [0, 255]. Use the
% randi function

figure()
imagesc(randImg)
colormap(cmap)

%% 2) Generate a sinusoidal image
% TODO make a vector representing a single column of the image

sinusoid=[]
for i=1:200
    sinusoid(i)=cos(i*pi/100)
end

% TODO "expand" the single column across the array using the repmat
% function

figure()
imagesc(sinusoid')
colormap(cmap)


%% 3) Demosaicing 
campanile_bayer = imread('campanile_bayer.bmp');

% TODO implement the demosaicPDI and demosaicBilinear functions in order to
% make the output image look properly demosaiced
campanile_pixel_doubling = demosaicPDI(campanile_bayer);
campanile_bilinear = demosaicBilinear(campanile_bayer);

figure('Position', [360, 463, 856, 235]) % create a figure of a particular size (units of pixels)
subplot(1, 3, 1)
imagesc(campanile_bayer)
title('Bayer filter output for campanile image')

subplot(1, 3, 2)
imagesc(campanile_pixel_doubling)
title('Pixel doubling interpolation')

subplot(1, 3, 3)
imagesc(campanile_bilinear)
title('Bilinear interpolation')

%% 4) Convert the bilinear interpolation version to grayscale for further processing
% TODO convert the output of the bilinear interpolation to grayscale using
% the NTSC standard formula provided in the PDF

% TODO render your grayscale image. 
R=0.2989*campanile_bilinear(:,:,1);
G=0.5870*campanile_bilinear(:,:,2);
B=0.1140*campanile_bilinear(:,:,3);

L=R + G + B;

figure()
imagesc(L)
colormap(cmap)


%% 5) Low-pass filtering
% TODO create an impulse response matrix representing the NxN moving
h=[1/25 1/25 1/25 1/25 1/25;1/25 1/25 1/25 1/25 1/25;1/25 1/25 1/25 1/25 1/25;1/25 1/25 1/25 1/25 1/25;1/25 1/25 1/25 1/25 1/25];
% average filter. DO NOT HARDCODE THE SIZE OF THE MATRIX, you'll have to
% change it in later parts of the lab.

% TODO use as the "x" input the grayscale image you just created in the
% last cell
LP=conv2(L,h,'same');
imagesc(LP)
colormap(cmap)
% TODO render your blurred image


%% 6) Edge detection
% TODO follow the instructions in the lab document for edge detection. 
hN=[0 -1 0;0 1 0;0 0 0];
hE=[0 0 0;0 1 -1;0 0 0];
YN=abs(conv2(L,hN,'same'));
YE=abs(conv2(L,hE,'same'));
threshold=50;
ZHE=[];
ZHN=[];

ZHE=YE>=threshold;
ZHN=YN>=threshold;
Znu=ZHE | ZHN;
Zf=1-Znu;
% for i=1:length(YN(:,1))
%     for j=1:length(YN(1,:))
%        if YN(i,j)<=threshold
%            ZHN(i,j)=1;
%        else 
%            ZHN(i,j)=0;
%        end
%     end
% end
% 
% for i=1:length(YE(:,1))
%     for j=1:length(YE(1,:))
%        if YN(i,j)<=threshold
%            ZHE(i,j)=1;
%        else 
%            ZHE(i,j)=0;
%        end
%     end
% end
% Z=[];
% for i=1:length(YN(:,1))
%     for j=1:length(YN(1,:))
%        if YN(i,j)==1 | YE==1
%            Z(i,j)=1;
%        else 
%            Z(i,j)=0;
%        end
%     end
% end
% 
% Z1=[];
% for i=1:length(Z(:,1))
%     for j=1:length(Z(1,:))
%        if Z(i,j)==1
%            Z1(i,j)=0;
%        else 
%            Z1(i,j)=1;
%        end
%     end
% end

figure()
imagesc(ZF)
colormap(cmap)
        

%% Denoisin
x = imread('Lena256Noisy.png');

% TODO use a 3x3 moving average filter to denoise the image
y_mean_filt = conv2(x,h,'same');

% TODO denoise the image using a median filter
new_x=padarray(x,[1 1]);
y_median_filt = new_x;
for m=2:length(x(:,1))
    for n=2:length(x(1,:))
        y_median_filt(m,n)=median([new_x(m-1,n-1) new_x(m-1,n) new_x(m-1,n+1) new_x(m,n-1) new_x(m,n) new_x(m,n+1) new_x(m+1,n-1) new_x(m+1,n) new_x(m+1,n+1)]);
    end
end


figure('Position', [360, 463, 856, 235]) % create a figure of a particular size (units of pixels)
subplot(1, 3, 1)
image(x)
title('Noisy image')
colormap(cmap)

subplot(1, 3, 2)
image(y_mean_filt)
title('Mean filter output')
colormap(cmap)

subplot(1, 3, 3)
image(y_median_filt)
title('Median filter output')
colormap(cmap)