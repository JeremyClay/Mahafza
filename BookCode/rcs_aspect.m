function [rcs] = rcs_aspect(scat_spacing, freq)
% This function demonstrates the effect of aspect angle on RCS
% The default frequency is 3GHz. The radar is observing two unity 
% point scatterers separated by 1.0 meters. Initially the two scatterers
% are aligned with radar line of sight. The aspect angle is changed from
% 0 degrees to 180 degress and the equivalant RCS is computed.
% The RCS as measured by the radar versus aspect angle is then plotted.
% Inputs 
    % scat_spacing in meters
    % freq radar frequency in Hz
%
% Output
    % rcs in dBsm    
% Users may vary frequency, and/or scatteres spacing to observe RCS variation
eps = 0.0001;
wavelength = 3.0e+8 / freq;
% Compute aspect angle vector
aspect_degrees = 0.:.05:180.;
aspect_radians = (pi/180) .* aspect_degrees;
% Compute electrical scatterer spacing vector in wavelength units
elec_spacing = (2.0 * scat_spacing / wavelength) .* cos(aspect_radians);
% Compute RCS (rcs = RCS_scat1 + RCS_scat2)
% Scat1 is taken as phase refernce point
rcs = abs(1.0 + cos((2.0 * pi) .* elec_spacing) ... 
            + i * sin((2.0 * pi) .* elec_spacing));
rcs = rcs + eps;
rcs = 20.0*log10(rcs); % RCS in dBsm 
end

