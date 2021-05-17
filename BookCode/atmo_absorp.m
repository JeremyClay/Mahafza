function [gammaO2, gammaH2O] = atmo_absorp(height,Wvd, freq)
% This function computes the atmospheric attenuation as a function of
% target height for up to 12 Km
% 
% Inputs
    % height    == target height array in Km
    % Wvd       == water vapor density array in g/m^3
    % freq      == radar operating frequency in Hz
%
% Outputs
    % gammaO2   == atmospheric attention due to oxygen in dB
    % gammaH2O  == atmospheric attention due to water vapor in dB
%
%format long
format short
ro = 6375;
v1 = 0.018;
v2 = .05;
v3 = 0.1;
v4 = 0.3;
lambda = 3e10/freq; % wavelength in cm
height = height ./1000;
T = 288 -6.7 .* height; % compute temperature array at different heights
pressure = 1015 .* (1-0.02275.*height).^5.2561;% compute air pressure array at different heights
% implement Eq. (8.115)
P = (v1 * 0.4909 .* pressure.^2) ./ (T.^(5/2)); 
Q = v1^2 * 2.904e-4 .* pressure.^2 ./ T;
gammaO2 = P .* (1./(1+Q.*lambda^2)) .* (1+ (1.39/lambda^2));
% implement Eq. (8.117)
P = 1.852 * 3.165e-6 .* Wvd .*pressure.^2 ./ (T.^(3/2));
Q1 = (1 - 0.742 * lambda)^2;
Q2 = (1 + 0.742 * lambda)^2;
Q = 2.853e-6 .* pressure.^2 ./T;
gammaH2O = P .*((1./(Q1 + Q .*lambda^2)) + (1./(Q2 + Q .*lambda^2)) + 3.43/lambda^2);
end



