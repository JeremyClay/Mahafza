function [Ru] = unambigRange(PRI)
%unambigRange calculates radar unambiguos range in meters. Eq1.6
%   Radar unambiguos range is computed by using the radar range equation 
%   with the Pulse Repitition Interval (PRI):
%
%   Ru = 0.5*(c*PRI) = 0.5*(c*T) = 0.5*(c/PRF)
%
%   Ru - Unambiguous Range (Meters) 
%   c - Speed of light (meters/second)
%   PRF - Pulse Repitition Frequency (Hertz)
%   T - Inter Pulse Period (seconds)
%   PRF - Pulse Repitition Frequency (Hertz)
%
%   Taken from 
%   Radar Systems Analysis and Design Using Matlab, Third Edition
%   Bassem R. Mahafza, 2012
%   Equation 1.6 page 10

% Constants
c=physconst('LightSpeed');

% Equation
Ru = 0.5*c*PRI;
end

