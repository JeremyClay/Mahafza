function [RR] = rangeResolution(input, ind)
%rangeResolution calculates Range Resolution from pulse width or bandwidth.Eq1.9
%   Radar range resolution calculates the minimum range resolution 
%   capability of a radar based on the pulse width (tau) or the bandwidth 
%   (B).  Use the ind (indicator) to select either pulse width (0) or 
%   bandwidth (1).  Range Resolution shows the minimum range two objects 
%   have to be separated by for a radar to discern between the two.  This 
%   is calcualted by using the simple range equation with the pulse width 
%   in the time variable.  Note that pulse width is equal to 1/B (bandwidth) 
%   which can be used instead of tau:
%
%   RR = 0.5*(c*tau) = (0.5*c)/B
%
%   RR - Range Resolution (Meters) 
%   c - Speed of light (meters/second)
%   tau - pulse width (seconds)
%   B - Bandwidth (Hz)
%
%   Taken from 
%   Radar Systems Analysis and Design Using Matlab, Third Edition
%   Bassem R. Mahafza, 2012
%   Equation 1.9 page 12

% Constants
c=physconst('LightSpeed');

if ind == 0
    % Equation
    RR = 0.5*(c*input);
elseif ind == 1
    % Equation
    RR = 0.5*c/input;
else
    disp('Incorrect indicator.  Select 0 for pulse width or 1 for bandwidth')
end

