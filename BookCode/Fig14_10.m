% This program calculates the back-scattered RCS for a perfectly
% conducting sphere using Eq.(14.28), and produce plots similar to Fig.14.10 
% Spherical Bessel functions are computed using series approximation and recursion.
clc
close all
clear all
eps   = 0.00001;
index = 0;
% kr limits are [0.05 - 15] ===> 300 points
for kr = 0.05:0.01:25
   index = index + 1;
   sphere_rcs   = 0. + 0.*i;
   f1    = 0. + 1.*i;
   f2    = 1. + 0.*i;
   m     = 1.;
   n     = 0.;
   q     = -1.;
   % initially set del to huge value
   del =100000+100000*i;
   while(abs(del) > eps)
      q   = -q;
      n   = n + 1;
      m   = m + 2;
      del = (2.*n-1) * f2 / kr-f1;
      f1  = f2;
      f2  = del;
      del = q * m /(f2 * (kr * f1 - n * f2));
      sphere_rcs = sphere_rcs + del;
   end
   rcs(index)   = abs(sphere_rcs);
   sphere_rcsdb(index) = 10. * log10(rcs(index));
   end
figure(1);
n=0.05:.01:25;
subplot(2,1,1)
plot (n,rcs,'k','linewidth',1.5);
% set (gca,'xtick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]);
xlabel ('\bfSphere circumference in wavelengths; (2 \pi r / \lambda)');
ylabel ('\bf Normalized RCS ( \sigma / \pi r^2)');
grid on
subplot(2,1,2)
plot (n,sphere_rcsdb,'k','linewidth',1.5);
%set (gca,'xtick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]);
xlabel ('\bfSphere circumference in wavelengths; (2 \pi r / \lambda)');
ylabel ('\bf Normalized RCS ( \sigma / \pi r^2) - dB');
grid;
figure (2);
semilogx (n,sphere_rcsdb,'k','linewidth',1.5);
xlabel ('\bfSphere circumference in wavelengths; (2 \pi r / \lambda)');
ylabel ('\bf Normalized sphere RCS ( \sigma / \pi r^2) - dB');
grid on
gtext('\bfRayleigh Region')
gtext('\bfMie Region')
gtext('\bfOptical Region')


