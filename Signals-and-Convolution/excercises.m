close all
clear all
%4 Excercises

%1. Correct step size to use is 1
%2. from (0 to 2pi)
%3.Yes there will still be a restriction because sinusoids are harmonic
%fucntions 
%It would be then dirac delta 
%5. the  length(y) = Max[length(x) + length(h) - 1, length(x), length(h)]
%6
% n = -10:1:10;
% x = sin(pi/8 * n);
% h = [0.5, 0.5];
% y_full = conv(x, h, 'full');
% y_valid = conv(x, h, 'valid');
% y_same = conv(x, h, 'same');
% figure()
% hold on
% stem([-10:11], y_full, 'b')
% stem([-9:10],y_valid, 'gx')
% stem([-9,11], y_same, 'r')

%7

n =0:1:30
while true
    omega0 = input('Please input a value for \omega_o ')
    x=cos(omega0*n)
    y1=[0.5, 0.5];
    y2=[0.5, -.5];
    y3=[0.5,0,0.5];
    c1=conv(x,y1);
    c2=conv(x,y2);
    c3=conv(x,y3);
    figure()
    subplot(2,2,1)
    stem(n,x)
    xlabel('\omega_ot')
    ylabel('input signal')
    
    subplot(2,2,2)
    stem([0:1:31],c1)
    xlabel('\omega_ot')
    ylabel('y1')
    
    subplot(2,2,3)
    stem([0:1:31],c2)
    xlabel('\omega_ot')
    ylabel('y2')
    
    subplot(2,2,4)
    stem([0:1:32],c3)
    xlabel('\omega_ot')
    ylabel('y3')
end 

%8
%I believe that from section 3.1  the system that matches the simple image
%behavior the best is y_full since it expresses all it's values

%9 
%a) looks like a discrete time signal  (sinusoidal)
%b)Yeah, it seems like the values in the middle were an  addition of two values
%while the edges values were the only values
     
   
    
    