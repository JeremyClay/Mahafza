% this program generates Fig. 8.17 of text
clear all
close all
clight = 3.0e8;
gg = linspace(0,200,500);
zz = 2.* (2*pi.* gg .* .3048/300).^2;
val1 = besseli(0,zz);
% index= find(val1 >1e20);
% val1(index) = 1e-12;
Sr = exp(-zz) ;
Srr = exp(-zz);
Srr1 = val1 .* Sr;
figure(1)
plot(gg,Sr,'k',gg,Srr1,'k-.','linewidth',1)
grid

