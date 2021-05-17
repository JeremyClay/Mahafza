function PAP = power_aperture(snr,tsc,sigma,range,nf,loss,az_angle,el_angle)
% This function implements Eq. (2.38) of textbook
%
% Inputs:
        % snr       == SNR in dB
        % tsc       == scan time in seconds
        % sigma     == radar cross section in meter squared
        % range     == range to target in Km
        % nf        == noise Figure in dB
        % loss      == total radar losses in dB
        % az_angle  == azimuth search extent in degrees
        % el_angle  == elevation search extent in degrees
%    
% Outputs:
        % PAP       == power aperture product in dB      
% 
Tsc = 10*log10(tsc); % convert Tsc into dB
Sigma = 10*log10(sigma); % convert sigma to dB
four_pi = 10*log10(4.0 * pi); % (4pi) in dB
k_db = 10*log10(1.38e-23); % Boltzman's constant in dB
To = 10*log10(290); % noise temp. in dB
range_pwr4_db = 10*log10(range.^4); % target range^4 in dB
omega = (az_angle/57.296) * (el_angle / 57.296); % compute search volume in steraradians
Omega = 10*log10(omega); % search volume in dB
% implement Eq. (1.79)
PAP = snr + four_pi + k_db + To + nf + loss + range_pwr4_db + Omega ...
    - Sigma - Tsc;
return
