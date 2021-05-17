function [PRF,outputArg2] = simplePRF(PRI)
%simplePRF calculates radar PRF in hertz. Eq1.2
%   Radar Pulse Repetition Frequency is computed by measuring the time 
%   between pulses of the radar, PRI(time), and calculating the inverse. 
%
%   PRF = 1/PRI = 1/T
%
%   PRF - Pulse Repetition Frequency (Hertz)
%   PRI - Pulse Repetition Interval (seconds)
%   T - Inter Pulse Period (seconds)
%
%   Taken from 
%   Radar Systems Analysis and Design Using Matlab, Third Edition
%   Bassem R. Mahafza, 2012
%   Equation 1.2 page 9

% Equation
PRF = 1/PRI;
end

