% generates Fig 14.12a of text
clc
close all
clear all
% Enter the ellpsiod a radius
a = .15;
% Enter the ellpsiod b radius
b = .3;
% Enter the ellpsiod c radius
c = .95;
% Enter the ellpsiod roll angle in degrees
phi = [0 75 90];
[rcs_db1] = rcs_ellipsoid (a, b, c, phi(1));
[rcs_db2] = rcs_ellipsoid (a, b, c, phi(2));
[rcs_db3] = rcs_ellipsoid (a, b, c, phi(3));
N = size(rcs_db1,2);
theta = linspace(0.0, pi, N);
theta = theta .* 180 ./ pi;
figure (1);
plot(theta,rcs_db1,'k:',theta,rcs_db2,'k',theta,rcs_db3,'k-.','linewidth',1.5);
xlabel ('\bfAspect angle - degrees');
ylabel ('\bfEllipsoid RCS - dBsm');
legend ('\phi = 0.0', '\phi = 75', '\phi = 90')
title('(a, b, c) = (.15, .3, .95) meters')
grid on;

    