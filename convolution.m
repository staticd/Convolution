%
%   Author: ncd 
%   Version: 0.1.0
%   Description:
%   -computes and displays convolution of two functions x and h
%   Usage:
%   >>>convolution<enter>
%

clc;
close all;
clear all;

% set up time domain for functions
% Note: must make step size really small in order to see a nice pulse
t_x = -10:1e-3:10; % x_domain
t_h = -10:1e-3:10; % h_domain
t_y = 0:1e-3:40;   % y_domain (conv vector is bigger)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set up functions to convolve
x = 2*(heaviside(t_x-1)-heaviside(t_x-2));
h = 3*(heaviside(t_h+8)-heaviside(t_h+4));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fourier equivalent
X = fft([x zeros(1,length(h)-1)]);
H = fft([h zeros(1,length(x)-1)]);

% perform convolution
y = conv(x,h);
w = ifft(X.*H);

% plot functions
subplot(2,2,1);
plot(t_x,x);
axis equal;
title('x(t)');

subplot(2,2,2);
plot(t_y,y/1e3);
axis equal;
title('y(t) = x(t) * h(t)');

subplot(2,2,3);
plot(t_h,h);
axis equal;
title('h(t)');

subplot(2,2,4);
plot(t_y,w/1e3);
axis equal;
title('w(t) (FFT equivalent)');

% check upper and lower limit of response
hit = 0;

for i = 1:length(y);
   if y(i) > 0 && hit == 0;
       disp([num2str(t_y(i)),' is the lower limit']);
       hit = 1;
   end
   if y(i) == 0 && hit == 1;
       disp([num2str(t_y(i-1)),' is the upper limit']);
       hit = 2;
   end
end
