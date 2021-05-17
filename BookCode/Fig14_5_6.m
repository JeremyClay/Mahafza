% Generates plot like Fig. 14.5 and Fig. 14.6 
% Enter scatterer spacing, in meters
clc
close all
clear all
scat_spacing = input('Enter scatterer spacing, in meters \n');
% Enter frequency band
freql = input('Enter lower frequency limit in Hz \n');
frequ = input('Enter upper frequency limit in Hz \n');
[rcs] = rcs_frequency (scat_spacing, frequ, freql);
N = size(rcs,2) ;
freq = linspace(freql,frequ,N)./1e9;
figure (1);
plot(freq,rcs);
grid on;
xlabel('\bfFrequency');
ylabel('\bfRCS in dBsm');

