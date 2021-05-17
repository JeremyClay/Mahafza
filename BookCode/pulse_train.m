function [dt, prf, pav, ep, ru] = pulse_train(tau, pri, p_peak)
% computes duty cycle, average transmitted power, pulse energy, and pulse repetition frequency
% Inputs:
    %   tau    == Pulsewidth in seconds
    %   pri    == Pulse repetition interval in seconds
    %   p_peak == Peak power in Watts
%
% Outputs:
    %   dt    == Duty cycle - unitless
    %   prf   == Pulse repetition frequency in Hz
    %   pa    == Average power in Watts
    %   ep    == Pulse energy in Joules
    %   ru    == Unambiguous range in Km
%
c = 3e8; % speed of light
dt = tau / pri;
prf = 1. / pri;
pav = p_peak * dt;
ep = p_peak * tau;
ru = 1.e-3 * c * pri /2.0;
return