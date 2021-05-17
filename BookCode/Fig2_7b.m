% This program produces Fig 2.7 of text
clc;
clear all
pt = 50.0e+3;    % peak power in Watts
g = 35.0;       % antenna gain in dB
freq = 5.6e+9;  % radar operating frequency in Hz
sigma = 10.0 ;    % radar cross section in m squared
b = 667.0e+3;    % radar operating bandwidth in Hz
loss = 0.1000;     % radar losses in dB
rangej = 50.0; % range to jammer in Km
pj = 200.0;    % jammer peak power in Watts
bj = 50.0e+6;  % jammer operating bandwidth in Hz
gj = 10.0; 		 % jammer antenna gain in dB
lossj = .10;    % jammer losses in dB
[BR_range] = ssj_req (pt, g, freq, sigma, b, loss, ...
   pj, bj, gj, lossj);
pj_var = 1:1:1000;
BR_pj = sqrt((pt * (10^(g/10)) * sigma * bj * (10^(lossj/10))) ...
   ./ (4.0 * pi .* pj_var * (10^(gj/10)) * b * (10^(loss/10)))) ./ 1000;
pt_var = 1000:100:10e6;
BR_pt = sqrt((pt_var * (10^(g/10)) * sigma * bj * (10^(lossj/10))) ...
   ./ (4.0 * pi .* pj * (10^(gj/10)) * b * (10^(loss/10)))) ./ 1000;
figure (2)
subplot (2,1,1)
semilogx (BR_pj,'k','linewidth',1.5)
xlabel ('Jammer peak power - Watts');
ylabel ('Cross-over range - Km')
grid
subplot (2,1,2)
semilogx (BR_pt,'k','linewidth',1.5)
xlabel ('Radar peak power - KW')
ylabel ('Cross-over range - Km')
grid
