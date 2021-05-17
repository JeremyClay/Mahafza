function pd = pd_swerling2 (nfa, np, snrbar)
% This function is used to calculate the probability of detection
% for Swerling 2 targets.
% Inputs
    % nfa       == number of fals alarm
    % np        == number of pulses
    % snrbar    == SNR
%
% Outputs
    % pd        == proability of detection
format long
snrbar = 10.0^(snrbar/10.);
delta = eps;
% Calculate the threshold Vt
pfa =  np * log(2) / nfa;
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
if (np <= 50)
   temp = vt / (1.0 + snrbar);
   pd = 1.0 - gammainc(temp,np);
   return
else
   temp1 = snrbar + 1.0;
   omegabar = sqrt(np) * temp1;
   c3 = -1.0 / sqrt(9.0 * np);
   c4 = 0.25 / np;
   c6 = c3 * c3 /2.0;
   V = (vt - np * temp1) / omegabar;
   Vsqr = V *V;
   val1 = exp(-Vsqr / 2.0) / sqrt( 2.0 * pi);
   val2 = c3 * (V^2 -1.0) + c4 * V * (3.0 - V^2) - ... 
      c6 * V * (V^4 - 10. * V^2 + 15.0);
   q = 0.5 * erfc (V/sqrt(2.0));
   pd =  q - val1 * val2;
end
return


