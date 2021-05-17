function [M] = rangeBins(Rmax,Rmin, RR)
%rangeBins calculates total range bins of a radar. Eq1.7
%   Radar range bins is computed by using the radar maximum and minum range
%   and dividing by the range resolution of the radar (RR).
%
%   M = (Rmax - Rmin)/RR
%
%   M - gates (unitless) 
%   Rmax - Maximum Range (meters)
%   Rmin - Minimum Range (meters)
%   RR - Range Resolution (meters)
%
%   Taken from 
%   Radar Systems Analysis and Design Using Matlab, Third Edition
%   Bassem R. Mahafza, 2012
%   Equation 1.7 page 12


% Equation
M = (Rmax-Rmin)/RR;
end

