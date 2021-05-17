% generates Fig 10.25 of text
clc
clear all
close all
format long
PRF = 1/400e-6;
taup = 1e-6;
sigma1 = 11.93;
sigma2 = 20.72;
phi0L = 10^-15.00;
phi0U = 10^-8;
phi0 = linspace(phi0L,phi0U,150000);
phi_ratio = phi0 ./ taup;

% two-pulse MTI
%%%% sigma1 %%%%
gns = 1/2 * (2*pi*sigma1/PRF)^2
den = gns + phi_ratio;
CA_NS = 10*log10(1.0 ./ den);
%%%% sigma2 %%%%%
gs = 1/2 * (2*pi*sigma2/PRF)^2;
den = gs + phi_ratio;
CA_S = 10*log10(1.0 ./ den);
x_axis = 10*log10(phi0);
figure(1)
plot(x_axis,CA_NS,'r-.',x_axis,CA_S,'b','linewidth',1.5)
grid
% axis([-135 -90 20 35])
xlabel('\bfPhase noise - dBc/HZ')
ylabel('\bfClutter attenuation - dB')
legend('\sigmaf = 11.92', '\sigmaf = 20.72')

