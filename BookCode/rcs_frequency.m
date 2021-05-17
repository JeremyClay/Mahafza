function [rcs] = rcs_frequency (scat_spacing, frequ, freql)
% This program demonstrates the dependency of RCS on wavelength 
% The default assumes two unity point scatterers separated 
% The radar line of sight is alinged with the two scatterers
% Inputs
    % scat_spacing in meters
    % freql lower frequency limit in Hz
    % frequ upper frequency limit in Hz
% Output
    % rcs in dBsm
eps = 0.0001;
freq_band = frequ - freql;
delfreq = freq_band / 500.;
index = 0;
for freq = freql: delfreq: frequ
   index = index +1;
   wavelength(index) = 3.0e+8 / freq;
end
% Compute electrical scatterer spacing vector in wavelength units
elec_spacing = 2.0 * scat_spacing ./ wavelength;
% Compute RCS (RCS = RCS_scat1 + RCS_scat2) 
rcs = abs (  1 + cos((2.0 * pi) .* elec_spacing) ... 
            + i * sin((2.0 * pi) .* elec_spacing));
rcs = rcs + eps;
rcs = 20.0*log10(rcs); % RCS ins dBsm
end
