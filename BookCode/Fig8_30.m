%Generates Figure 8.30 of text
clc
clear all
close all
freq =428e6;
hr = 3000; 
ht = 200;
%%%%%%%%%%%%% input %%%%%%%%%%%%%%%%
ro = 6375e3; % earth radius
re = ro * 4 /3; % 4/3 earth radius
lambda = 3.0e8 / freq; % wavelength
Rd1 = linspace(75e3, 210.1e3, 800); % slant range 3 to 55 Km 500 points
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

figure(2)
plot(Rd./1000, F_dbr,'r','linewidth',1)
grid
xlabel('slant range in Km')
ylabel('Propagation factor in dB')
axis tight
title('frequency = 428 MHz; ht = 3000 m; hr = 200 m')


R = linspace(210.1e3,350e3,200); % range in Km
nt =1500; % number of point used in calculting infinite series
F = diffraction(freq, hr, ht,R,nt);
figure(3)
plot(R/1000,10*log10(abs(F).^2),'k','linewidth',1)
grid 
xlabel('Range - Km')
ylabel('One way propagation factor - dB')
title('frequency = 428 MHz; hr = 3000 m; ht = 2000 m')
figure(4)
plot(Rd./1000, F_dbr,'k','linewidth',1.)
hold on
plot(R/1000,10*log10(abs(F).^2),'k-.','linewidth',1.5)
grid on
hold off
axis tight
title('frequency = 428 MHz; hr = 3000 m; ht = 2000 m')
legend('Intermediate region', 'Diffraction region')
ylabel('Propagation factor in dB')
xlabel('Range in Km')


