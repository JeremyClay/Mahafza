function [range] = simpleRange(time)
%SimpleRange calculates radar range in meters. Eq1.1
%   Simple Radar Range is computed by measuring the time delay (time)it takes a
%   pulse to travel the two way path between the radar and the target.
%   Since electromagnetic waves travel at the speed of light, c=3*10^8 m/s
%   then
%
%   R = 0.5*(c*time)
%
%   R - Range (meters)
%   c - Speed of light (meters/second)
%   time - (seconds)
%
%   Taken from 
%   Radar Systems Analysis and Design Using Matlab, Third Edition
%   Bassem R. Mahafza, 2012
%   Equation 1.1 page 9

% Constants
c=physconst('LightSpeed');

% Equation 
range = 0.5*c*time;
end

