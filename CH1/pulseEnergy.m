function [Ep] = pulseEnergy(Pt,tau)
%pulseEngery calculates radar pulse energy in Joules. Eq1.4
%   Radar pulse energy is computed by calculating peak power (Pt) and 
%   multiplying by pulse width (tau):
%
%   Ep = Pt*tau = Pav*T=Pav/PRF
%
%   Ep = Pulse Energy (Joules)
%   Pt = Peak Power (Watts)
%   τ - Pulse width (seconds)
%   Pav - Average Power (Watts)
%   T - Inter Pulse Period (seconds)
%   PRF - Pulse Repitition Frequency (Hertz)
%
%   Taken from 
%   Radar Systems Analysis and Design Using Matlab, Third Edition
%   Bassem R. Mahafza, 2012
%   Equation 1.4 page 10

% Equation
Ep = Pt*tau;
end

