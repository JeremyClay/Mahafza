% Use this code to produce Fig. 15.5a and 15.5 based on equation 15.35
clc
clear all
close all
eps = 0.00001;
k = 2*pi;
theta = -pi : pi / 10791 : pi;
var = sin(theta);
nelements = 8;
d = 1;         %  d = .5;
num = sin((nelements * k * d * 0.5) .* var);

if(abs(num) <= eps)
   num = eps;
end
den = sin((k* d * 0.5) .* var);
if(abs(den) <= eps)
   den = eps;
end

pattern = abs(num ./ den);
maxval = max(pattern);
pattern = pattern ./ maxval;

figure(1)
plot(var,pattern,'linewidth', 1.5)
xlabel('\bfsine angle - dimensionless')
ylabel('\bfArray pattern')
grid

figure(2)
plot(var,20*log10(pattern),'linewidth', 1.5)
axis ([-1 1 -60 0])
xlabel('\bfsine angle - dimensionless')
ylabel('\bfPower pattern [dB]')
grid;

figure(3)
theta = theta +pi/2;
polar(theta,pattern)
title ('\bfArray pattern')

