close all
clear all
%2.1
omegaO=2*pi*1.24;

t1=-10:0.1:10;
x1=sin(omegaO*t1);

t2=-10:0.01:10;
x2=sin(omegaO*t2);

t3=-10:0.001:10;
x3=sin(omegaO*t3);
length(x1);
length(x2);
length(x3);
figure()
hold on
%plot(t1, x1, 'r')
%plot(t2, x2, 'g')
%plot(t3, x3, 'b')
%The lengths of each vector compare that they are factor of 10 apart from
%their corresponding step size going from  0.1 to 0.001.
%The more samples we have the better the representation of our signals.
%Very Important! If we are trying to represent a continuos-time signal
%x(t), the stepsize of the time veriable may be lass than 1. If we are
%trying to represent a discrete signal the step must be 1!

%2.2 Two Dimensional Signals
%x = imread('resistor.jpg');
%figure();
%image(x);

%x should be an M x N x 3 matrix. A 3D matrix is necessary to represent
%color images

%3 Convolution & Impulse response
%Convolution is an operation on two signal
% The convolutions of the the signals for that are non-zero for a finite
% period seems to superimpose and as the area shared between them becomes
% larger the output becomes larger.
% If we take two square signals we get a triangular signal. 
%it does agree with the notion of "overlapping" because as we see that they
%shared both total areas the output signal is at its highest point.


%3.1 Convolution using Matlab
% n=-20:20
% x=cos(pi*n/3)
% h=sin(n)

y_full = conv(x, h, 'full');
y_valid = conv(x, h, 'valid');
y_same = conv(x, h, 'same');
figure()
subplot(3, 1, 1)
stem(y_full, 'b')
title('full (default)')

subplot(3, 1, 2)
stem(y_valid, 'gx')
title('valid')

subplot(3, 1,3)
stem(y_same, 'r')
title('same')






