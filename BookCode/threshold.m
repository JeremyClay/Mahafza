function [pfa, vt] = threshold (nfa, np)
% This function calculates the threshold value from nfa and np.
% The newton-Raphson  recursive formula 
% This function uses "gammainc.m".
% Inputs
    % nfa       == number of false alarm
    % np        == number of pulses
%
% Outputs
    % Pfa        == probability of false alarm
    % vt         == threshold 
%
delta = eps;
pfa = np * log(2) / nfa;
sqrtpfa = sqrt(-log10(pfa));
sqrtnp = sqrt(np); 
vt0 = np - sqrtnp + 2.3 * sqrtpfa * (sqrtpfa + sqrtnp - 1.0);
vt = vt0;
while (delta < (vt0/10000));
   igf = gammainc(vt0,np);
   num = 0.5^(np/nfa) - igf;
   deno = -exp(-vt0) * vt0^(np-1) /factorial(np-1);
   vt = vt0 - (num / (deno+eps));
   delta = abs(vt - vt0);
   vt0 = vt;
end



  
