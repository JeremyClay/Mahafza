function [fd, tdr] = doppler_freq (freq, ang, tv)
% This function computes Doppler frequency and time dilation factor ratio
% tau_prime / tau
% 
% Inputs:
    % freq  == radar operating frequency in Hz
    % ang   == target aspect angle in degrees
    % tv    == target velocity in m/sec
%    
% Outputs:
    % fd    == Doppler frequency in Hz
    % tdr   == time dilation factor; unitless
%
format long
indicator = input('Enter 1 for closing target, OR 2 for opening target \n');
c = 3.0e+8;
ang_rad = ang * pi /180.;
lambda = c / freq;
switch(indicator)
    case 1
        fd = 2.0 * tv * cos(ang_rad) / lambda;
        tdr = (c - tv) / (c + tv);
    case 2
        fd = -2.0 * c * tv * cos(and_rad) / lambda;
        tdr = (c + tv) / (c -tv);
end
return