% Use this code to generate Fig. 9.12 or 9. 13 of text
clear all
close all
k = 1.38e-23; % Boltzmann's constant
T0 = 290; % degrees Kelvin
ant_id = 2; % use 1 for sin(x)/x antenna pattern and use 2 for Gaussian pattern
theta_ref = 0.75; % reference angle of radar antenna in degrees
re = 6371000 * 4 /3; %4 3rd earth radius in Km
c = 3e8; % speed of light
theta_EL = 1.5; % Antenna elevation beamwidth in degrees
theta_AZ = 2; % Antenna azimuth beamwidth in degrees
SL_dB = -25; % Antenna RMS sidelobe level
hr = 3; % Radar antenna hieght in meters
ht = 150; % Target hieght in meters
Sigmmat = -10; % Target RCS in dB
Sigmma0 = -20; % Clutter backscatter coefficient
P = 45e3; % Radar peak power in Watts
tau = 1e-6; % Pulse width (unmodulated)
fr = 50e3; % PRF in Hz
f0 = 5e9; % Radar center frequency
F = 6; % Noise figure in dB
L = 10; % Radar losses in dB
lambda = c /f0; 
SL = 10^(SL_dB/10);
sigmma0 = 10^(Sigmma0/10);
F = 10^(F/10);
L = L^(L/10);
sigmmat = 10^(Sigmmat/10);
T = 1/fr; % PRI
B = 1/tau; % Bandwidth
delr = c * tau /2; % Range resolution;
Rh = sqrt(2*re*hr); % Range to Horizon
R1 = [2*delr:delr:c/2*(T-tau)]; 
Rclut = sqrt(R1.^2 + hr^2); % Range to clutter patches
G = 26000 /theta_EL /theta_AZ; %Antenna gain
for j = 0:40
    Rtgt = [c/2*(j*T+2*tau):delr:c/2*((j+1)*T-tau)];
    thetaR = asin(hr./Rclut); % Elevation angle from radar to clutter patch where traget is present
    thetae = theta_ref *pi/180;
    d = Rclut .* cos(thetaR); % Ground range to center of clutter at range Rclut
    del_d = delr .* cos(thetaR);
    % claculte clutter RCS
    theta_sum = thetaR+thetae;
    if(ant_id ==1) % use sinc^2 antenna pattern
        ant_arg = ( theta_sum ) ./ (pi*theta_EL/180);
        gain = (sinc(ant_arg)).^2;
    else
        gain = exp(-2.776 .*(theta_sum./(pi*theta_EL/180)).^2);
    end
    % clutter RCS
    sigmmac = (pi*SL^2+(theta_AZ*pi/180).*gain.*sigmma0.*d.*del_d) ./ (1+(Rclut/Rh).^4);
    CNR = P*G*G*lambda^2 .* sigmmac ./ ((4*pi)^3 .* Rclut.^4 .* k*T0*F*L*B); % CNR
    SNR = P*G*G*lambda^2 .* sigmmat ./ ((4*pi)^3 .* Rtgt.^4 .* k*T0*F*L*B); % SNR
    SCR = SNR ./ CNR; % Signal to clutter ratio
    SIR = SNR ./ (1+CNR); % Signal to interfernce ratio
    figure(2)
    subplot(4,1,1), hold on
    plot(Rtgt/1000,10*log10(SNR),'linewidth',1.5);
    ylabel('\bfSNR in dB'); grid on
    subplot(4,1,2), hold on
    plot(Rtgt/1000,10*log10(CNR),'linewidth',1.5);
    ylabel('\bfCNR in dB');grid on
    subplot(4,1,3), hold on
    plot(Rtgt/1000,10*log10(SCR),'linewidth',1.5);
    ylabel('\bfSCR in dB') ;grid on
    subplot(4,1,4), hold on
    plot(Rtgt/1000,10*log10(SIR),'linewidth',1.5);
    xlabel('\bfRange in Km')
    ylabel('\bfSIR in dB');grid on
    end

subplot(4,1,1)
axis([0 50 -10 100])
subplot(4,1,2)
axis([0 50 60 110]);
subplot(4,1,3)
axis([0 50 -110 0])
subplot(4,1,4)
axis([0 50 -110 0])
    
    