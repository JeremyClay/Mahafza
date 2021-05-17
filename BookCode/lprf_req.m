function [snr] = lprf_req(pt, g, freq, sigma, np, b, nf, loss, range)
% This program implements Eq. (2.27) of textbook
%
% Inputs:
        % pt        == input peak power in Watts
        % freq      == radar operating frequency in Hz
        % g         == antenna gain in dB
        % sigma     == radar cross section in meter squared
        % b         == radar bandwidth in Hz
        % nf        == noise Figure in dB
        % np        == number of pulses
        % loss      == total radar losses in dB
        % range     == range to target (single value or vector) in Km
%    
% Outputs:
        % snr       == SNR in dB     
% 
c = 3.0e+8; % speed of light
lambda = c / freq; % wavelength
p_peak = 10*log10(pt); % convert peak power to dB
lambda_sqdb = 10*log10(lambda^2); % compute wavelength square in dB
sigmadb = 10*log10(sigma); % convert sigma to dB
four_pi_cub = 10*log10((4.0 * pi)^3); % (4pi)^3 in dB
k_db = 10*log10(1.38e-23); % Boltzman's constant in dB
to_db = 10*log10(290); % noise temp. in dB
b_db = 10*log10(b); % bandwidth in dB
np_db = 10.*log10(np); % number of pulses in dB
range_pwr4_db = 10*log10(range.^4); % vector of target range^4 in dB
% Implement Equation (1.68)
num = p_peak + g + g + lambda_sqdb + sigmadb + np_db;
den = four_pi_cub + k_db + to_db + b_db + nf + loss + range_pwr4_db;
snr = num - den;
return
