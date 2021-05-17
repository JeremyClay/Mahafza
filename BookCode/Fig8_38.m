clc
clear all
close all
format long
v3 = 0.1;
v4 = 0.3;
vw = 0.742;
freq = linspace(1e9,400e9,1000);
lambda = 3e10./freq; % wavelength in cm
index1 = find(freq <=22.2e9);
index2 = find(freq>22.2e9);
v = 1./lambda;
T = 288 ; 
P = 1015 ;
% implement Eq. (8.117)

Q1(index1) = 1.012e-3 * vw * P .*v(index1).^2 ./T;
Q2(index1) = 1.689e-2 .* P .* v3 ./ T;
Q3(index1)= (vw -v(index1)).^2;
Q4(index1) = (1.689e-2 .* P .*v3 ./sqrt(T)).^2;
Q5 = sqrt(Q4);
Q6(index1) = (vw+v(index1)).^2;
Q7 = Q4;
Q8 = 3.471e-3 .* vw .* P .* v(index2).^2 ./T;
Q9 = 1.689e-2 .* P .* v4 ./ sqrt(T);

gammaH2O(index1) = Q1 .*( (Q2 ./ (Q3+Q4) ) + (Q5 ./ (Q6+Q7)));

gammaH2O(index2) =  Q9 .*Q9;
atten = 10*log10(gammaH2O );
figure(1)
semilogy(freq./1e9,atten)
grid




