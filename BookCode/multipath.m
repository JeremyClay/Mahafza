% This program calculates and plots the propagation factor versus
% target range with a fixed target hieght.
% The free space radar-to-target range is assumed to be known.
clear all 
close all
eps = 0.01;
%%%%%%%%%%%%% input %%%%%%%%%%%%%%%%
ro = 6375e3; % earth radius
re = ro * 4 /3; % 4/3 earth radius
freq = 3000e6; % frequency
lambda = 3.0e8 / freq; % wavelength
hr = 30.48; % radar height in meters
ht = 2 .* hr; % target height in meters
Rd1 = linspace(2e3, 55e3, 500); % slant range 3 to 55 Km 500 points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% determine whether the traget is beyond the radar's line of sight
range_to_horizon = sqrt(2*re) * (sqrt(ht) + sqrt(hr)); % range to horizon
index = find(Rd1 > range_to_horizon);
if isempty(index);
    Rd = Rd1;
else
    Rd = Rd1(1:index(1)-1);
    fprintf('****** WARNING ****** \n')
    fprintf('Maximum range is beyond radar line of sight. \n')
    fprintf('Traget is in diffraction region \n')
    fprintf('****** WARNING ****** \n')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
val1 = Rd.^2 - (ht -hr).^2;
val2 = 4 .* (re + hr) .* (re + ht);
r = 2 .* re .* asin(sqrt(val1 ./ val2));
phi = r ./ re; 
p = sqrt(re .* (ht + hr) + (r.^2 ./4)) .* 2 ./ sqrt(3); 
exci = asin((2 .* re .* r .* (ht - hr) ./ p.^3)); 
r1 = (r ./ 2) - p .* sin(exci ./3);
phi1 = r1 ./ re; 
r2 = r - r1;
phi2 = r2 ./ re; 
R1 = sqrt( re.^2 + (re + hr).^2 - 2 .* re .* (re + hr) .* cos(phi1)); 
R2 = sqrt( re.^2 + (re + ht).^2 - 2 .* re .* (re + ht) .* cos(phi2)); 
psi = asin((2 .* re .* hr + hr^2 - R1.^2) ./ (2 .* re .* R1));
deltaR = R1 + R2 - Rd; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% input surface roughness %%%%%%%%%%%%%%%%
hrms = 1; % 
psi = psi .* 180 ./ pi;
[Sr] = surf_rough(hrms, freq, psi);
%%%%%%%%%%%%% input divergence %%%%%%%%%%%%%%%%
[D] = divergence(r1, r2, ht, hr, psi);
%%%%%%%%%%%%% input smooth earth ref. coefficient %%%%%%%%%%%
epsp = 50;
epspp = 15;
[rh,rv] = ref_coef (psi, epsp, epspp);
D = 1;
 Sr =1;
gamav = abs(rv);
phv = angle(rv);
gamah = abs(rh);
phh = angle (rh);
 gamav =1;
 phv = pi;
Gamma_mod = gamav .* D .* Sr; 
Gamma_phase = phv; %
rho = Gamma_mod;
delta_phi = 2 .* pi .* deltaR  ./ lambda; 
alpha = delta_phi + phv;
F = sqrt( 1 + rho.^2 + 2 .* rho .* cos( alpha)); 
Ro = 185.2e3; % refrence range in Km
F_free = 40 .* log10(Ro ./ Rd);
F_dbr = 40 .* log10( F .* Ro ./ Rd);
F_db = 40 .* log10( eps + F );
figure(1)
plot(Rd./1000, F_db,'k','linewidth',1)
grid
xlabel('slant range in Km')
ylabel('propagation factor in dB')
axis tight
axis([2 55 -60 20])
figure(2)
plot(Rd./1000, F_dbr,'k',Rd./1000, F_free,'k-.','linewidth',1)
grid
xlabel('slant range in Km')
ylabel('Propagation factor in dB')
axis tight
axis([2 55 -40 80])
legend('with multipath','free space')
title('frequency = 3GHz; ht = 60 m; hr = 30 m')


