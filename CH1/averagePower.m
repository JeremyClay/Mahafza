function [Pav] = averagePower(Pt,dt)
%averagePower calculates radar average power in Watts. Eq1.3
%   Radar average power is computed by calculating peak power and duty 
%   cycle and multiplying the two together:
%
%   Pav = Pt*dt = Pt*(τ/T)
%
%   Pav - Average Power (Watts)
%   Pt = Peak Power (Watts)
%   dt = Duty Cycle (Unitless)
%   τ - Pulse width (seconds)
%   T - Inter Pulse Period (seconds)
%
%   Taken from 
%   Radar Systems Analysis and Design Using Matlab, Third Edition
%   Bassem R. Mahafza, 2012
%   Equation 1.3 page 10

% Equation
Pav = Pt/dt;
end

