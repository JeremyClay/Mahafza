function [snr] = hprf_req (pt, Ti, g, freq, sigma, dt, range, nf, loss)
% This program implements Eq. (2.31)of textbook
%
% Inputs:
        % pt        == input peak power in Watts
        % freq      == radar operating frequency in Hz
        % g         == antenna gain in dB
        % sigma     == radar cross section in meter squared
        % Ti        == time on target in seconds
        % nf        == noise Figure in dB
        % dt        == duty cycle
        % loss      == total radar losses in dB
        % range     == range to target (single value or vector) in Km
%    
% Outputs:
        % snr       == SNR in dB     
% 
c = 3.0e+8; % speed of light
lambda = c / freq; % wavelength
pav = 10*log10(pt*dt); % compute average power in dB
Ti_db = 10*log10(Ti); % time on target in dB
lambda_sqdb = 10*log10(lambda^2); % compute wavelength square in dB
sigmadb = 10*log10(sigma); % convert sigma to dB
four_pi_cub = 10*log10((4.0 * pi)^3); % (4pi)^3 in dB
k_db = 10*log10(1.38e-23); % Boltzman's constant in dB
to_db = 10*log10(290); % noise temp. in dB
range_pwr4_db = 10*log10(range.^4); % vector of target range^4 in dB
% Implement Equation (1.72)
num = pav + Ti_db + g + g + lambda_sqdb + sigmadb;
den = four_pi_cub + k_db + to_db + nf + loss + range_pwr4_db;
snr = num - den;
return
