function [gammaO2, gammaH2O,range] = absorption_range(height,Wvd, freq,beta)
% This function computes the atmospheric absorption as a function of
% target height and range
% 
% Inputs
    % height    == target height array in Km
    % Wvd       == water vapor density array in g/m^3
    % freq      == radar operating frequency in Hz
    % beta      == intial elevation angle in degrees
%
% Outputs
    % gammaO2   == atmospheric absorption due to oxygen in dB
    % gammaH2O  == atmospheric absorption due to water vapor in dB
    % A_km      == atmospheric absorption versu range
%
format long
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
% convert beta into radian 
beta = beta * pi /180.; 
% calcualte array of r0 plus target height
r = ro + height;
alpha =asin(cos(beta) * ro ./r);
theta = (pi/2) - beta - alpha;
% range = sqrt(ro^2 + r.^2 - 2 * cos(theta) * ro .* r);
range = r .* sin(theta) / cos(beta); 
end

