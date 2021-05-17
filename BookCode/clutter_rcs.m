function [sigmaC] = clutter_rcs(sigma0, thetaE, thetaA, SL, range, hr, ht, b,ant_id)
% This unction calculates the clutter RCS and the CNR for a ground based radar.
%
% Inputs
    % sigma0        == clutter back scatterer coefficient	dB
    % thetaE        == antenna 3dB elevation beamwidth	degrees
    % thetaA        == antenna 3dB azimuth beamwidth	degrees
    % SL            == antenna side-lobe level	dB
    % range         == range; can be a vector or a single value	Km
    % hr            == radar height	meters
    % ht            == target height	meters
    % b             == bandwidth	Hz
    % ant_id        == 1 for (sin(x)/x)^2 pattern; 2 for Gaussian pattern 	

%
% Outputs
    % sigmac        == clutter RCS; vector or single value depending on “range”	dB
%
thetaA = thetaA * pi /180; % antenna azimuth beamwidth in radians
thetaE = thetaE * pi /180.; % antenna elevation beamwidth in radians
re = 6371000; % earth radius in meter
rh = sqrt(8.0*hr*re/3.); % range to horizon in meters
SLv = 10.0^(SL/10); % radar rms sidelobes in volts
sigma0v = 10.0^(sigma0/10); % clutter backscatter coefficient 
deltar = 3e8 / 2 / b; % range resolution for unmodulated pulse
range_m = 1000 .* range;  % range in meters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thetar = asin(hr ./ range_m);
thetae = asin((ht-hr) ./ range_m);
propag_atten = 1. + ((range_m ./ rh).^4); % propagation attenuation due to round earth
Rg = range_m .* cos(thetar);
deltaRg = deltar .* cos(thetar);
theta_sum = thetae + thetar;
% use sinc^2 antenna pattern when ant_id=1
% use Gaussian antenna pattern when ant_id=2
if(ant_id ==1) % use sinc^2 antenna pattern
    ant_arg = (theta_sum ) ./ (pi*thetaE);
    gain = (sinc(ant_arg)).^2;
else
    gain = exp(-2.776 .*(theta_sum./thetaE).^2);
end
% compute sigmac
sigmac = (sigma0v .* Rg .* deltaRg) .* (pi * SLv * SLv + thetaA .* gain.^2) ./ propag_atten;
sigmaC = 10*log10(sigmac);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(range, sigmaC,'linewidth',1.5)
grid
xlabel('\bfSlant Range in Km')
ylabel('\bfClutter RCS in dBsm')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






