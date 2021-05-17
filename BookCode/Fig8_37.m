% generates Fig 8.37 of text
clc
clear all
close all
format long
alpha = 0.00349;
beta = 0.00224;
freq = [1e9 5e9 10e9];
lambda = 3e10 ./ freq; % wavelength in cm;
r = linspace(0,1,1000); % rai fall rate i mm/hr
Att1 = (0.0035 .* r.^2 ./lambda(1)^4) + 0.0022 .* r ./ lambda(1);
Att2 = (0.0035 .* r.^2 ./lambda(2)^4) + 0.0022 .* r ./ lambda(2);
Att3 = (0.0035 .* r.^2 ./lambda(3)^4) + 0.0022 .* r ./ lambda(3);
figure(1)
semilogy(r,Att3, 'k:',r,Att2,'k-.',r,Att1,'k','linewidth',1.5)
xlabel('\bf Snow  rate <==> water equivalnet in mm/hr')
ylabel('\bfone-way attenuation due to snow fall dB/Km')
grid on
legend('freq = 10Ghz','freq = 5GHz','freq = 1GHz')
