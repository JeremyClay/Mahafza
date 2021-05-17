function [Range] = burn_thru (pt, g, sigma, freq, tau, loss, pj, bj, gj, lossj,sir0,ERP);
% This function implements Eq. (254) of textbook
% 
% Inputs
        % pt        == radar peak power in Watts
        % g         == radar antenna gain in dB
        % freq      == radar operating frequency in Hz
        % tau       == radar pulse width in seconds
        % loss      == radar losses in dB
        % pj        == jammer power in Watts
        % bj        == jammer bandwidth in Hz
        % gj        == jammer antenna gain in dB
        % loosj     == jammer losses in dB
        % sir0      == desired SIR in dB
        % ERP       == desired jammer ERP, single value or vector in Watts
%
% Outputs
        % Range  == burn through range in Km
c = 3.0e+8;
k = 1.38e-23;
sir0 = 10^(sir0/10);
lambda = c / freq;
gj = 10^(gj/10);
G = 10^(g/10);
Ar = lambda *lambda * G / 4 /pi;
num32 = ERP .* Ar;
demo3 = 8 *pi * bj * k * 290;
demo4 = 4^2 * pi^2 * k * 290 * sir0;
val1 = (num32 ./ demo3).^2;
val2 = (pt * tau * G * sigma * Ar)/(4^2 * pi^2 * loss * sir0 * k * 290);
val3 = sqrt(val1 + val2);
val4 = (ERP .* Ar) ./ demo3;
Range = sqrt(val3 - val4) ./ 1000;
end
