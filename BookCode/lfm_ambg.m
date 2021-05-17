function x = lfm_ambg(taup, b, up_down)
% Implements Eq. (5.21) of textbook
%
% Inputs
    % taup      == pulsewidth in seconds
    % b         == bandwidth in Hz 
    % up_down	== 1 to indicate an up-chirp LFM
    % up_down   == -1 to indicate an down-chirp LFM
%
% Output
    % x         == ambiguity matrix
%
eps = 0.000001;
i = 0;
mu = up_down * b / taup;
del = 2*taup/200;
for tau = -1.*taup:del:taup
   i = i + 1;
   j = 0;
   fd = linspace(-1.5*b,1.5*b,201);
   val1 = 1. - abs(tau) / taup;
   val2 = pi * taup * (1.0 - abs(tau) / taup);
   val3 = (fd + mu * tau);
   val = val2 * val3;
   x(:,i) = abs( val1 .* (sin(val+eps)./(val+eps))).^2;
   end
end



