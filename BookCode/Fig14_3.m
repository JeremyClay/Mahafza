% generates Fig. 14.3 of text
clc
close all
clear all
% Enter scatterer spacing, in meters
distance = input('Enter scatterer spacing, in meters \n');
% Enter frequency
freq = input('Enter Enter frequency in Hz \n');
rcs = rcs_aspect(distance,freq);
figure (1);
aspect_degrees = 0.:.05:180.;
plot(aspect_degrees,rcs);
grid;
xlabel('\bfaspect angle - degrees');
ylabel('\bfRCS in dBsm');

