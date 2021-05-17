function pd = pd_swerling5 (input1, indicator, np, snrbar)
% This function is used to calculate the probability of detection
% for Swerling 5 or 0 targets for np>1.
%
% Inputs
    % input1        == Pfa or nfa
    % indicator     == 1 when input1 = Pfa; 2 when input1 = nfa
    % np            == number of pulses
    % snrbar        == SNR
% Outputs
    % pd        == probability of detection
if(np == 1)
   'Stop, np must be greater than 1'
   return
end
format long
snrbar = 10.0.^(snrbar./10.);
eps = 0.00000001;
delta = eps;
% Calculate the threshold Vt
if (indicator ~=1)
   nfa = input1;
   pfa =  np * log(2) / nfa;
else
   pfa = input1;
   nfa = np * log(2) / pfa;
end
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
% Calculate the Gram-Chrlier coefficients
temp1 = 2.0 .* snrbar + 1.0;
omegabar = sqrt(np .* temp1);
c3 = -(snrbar + 1.0 / 3.0) ./ (sqrt(np) .* temp1.^1.5);
c4 = (snrbar + 0.25) ./ (np .* temp1.^2.);
c6 = c3 .* c3 ./2.0;
V = (vt - np .* (1.0 + snrbar)) ./ omegabar;
Vsqr = V .*V;
val1 = exp(-Vsqr ./ 2.0) ./ sqrt( 2.0 * pi);
val2 = c3 .* (V.^2 -1.0) + c4 .* V .* (3.0 - V.^2) -...
   c6 .* V .* (V.^4 - 10. .* V.^2 + 15.0);
q = 0.5 .* erfc (V./sqrt(2.0));
pd =  q - val1 .* val2;
return