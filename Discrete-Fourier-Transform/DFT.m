%% 1D downsampling and antialiasing filter


%% Resize the image
% Try this with the Mona Lisa too, and experiment with different resize
%  factors.

im = imread('font.jpg');
% im = imread('monalisa.jpg');

resizeFactor = 4;  % reduce each dimension by a factor of resizeFactor
%The quality of the image gets gets pixelated. It looks like this because
%high-frequency components  become indistinguishable from lower frequencies
%do to spectral expansion.
omega=-pi:0.025:pi;
X=max(0, 1-(2/pi)*abs(omega)) + (abs(abs(omega)-abs(pi*0.4))<0.05);
figure()
hold on
plot(omega,X)
F=ifft(ifftshift(X));
F1=F(1:2:end);
X1=fftshift(fft(F1));
omegadt=omega(1:2:end);
plot(omegadt,X1)
% you dont see aliasing, the is signal is streched by a factor of two just
% as we expected.
F2=F(1:3:end);
X2=fftshift(fft(F2));
omega3=omega(1:3:end);
plot(omega3,X2,'g')
hold on
%Here you can clearly notice the aliasing where the frequency is constant.
%The aliased spectrum look this way because we can not differ from the high
%frequency and low frequency.

%if we're going to want to downsample my time domain signal by a factor of
%3 by bandwith should be from -pi/3 to pi/3
Bn=-pi/3;
Bp=-Bn;

LPF=(omega >Bn) & (omega<Bp);
CN=LPF.*X;
FF=ifft(ifftshift(CN));
FF=FF(1:3:end);
XF=fftshift(fft(FF));
plot(omega3,abs(XF));

%%


resizedResampling = resizeResample(im,resizeFactor);
resizedMeanFilter = resizeMeanFilter(im,resizeFactor);
resizedIdeal      = resizeIdeal(im,resizeFactor);

figure(3)
subplot(1,3,1)
image(resizedResampling)
title('Subsample')
subplot(1,3,2)
image(resizedIdeal)
title('Ideal LP filter')
subplot(1,3,3)
image(resizedMeanFilter)
title('Mean Filter')
%4.2
%The reasons why we see much more error in the campanile is due to the
%fact the campanile has the right side mostly white throwing away more
%components
%4.4
%the degrading with compression 5 is barely noticeable .
%4.5
%It looks like the Ideal Low-pass filter