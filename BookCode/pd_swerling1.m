function pd = pd_swerling1 (nfa, np, snrbar)
% This function is used to calculate the probability of detection
% for Swerling 1 targets.
%
% Inputs
    % nfa       == Marcum’s false alarm number
    % np        == number of integrated pulses
    % snrbar    == SNR 
%
% outputs
    % pd        == probability of detection
format long
snrbar = 10.0^(snrbar/10.);
eps = 0.00000001;
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
if (np == 1)
   temp = -vt / (1.0 + snrbar);
   pd = exp(temp);
   return
end
   temp1 = 1.0 + np * snrbar;
   temp2 = 1.0 / (np *snrbar);
   temp = 1.0 + temp2;
   val1 = temp^(np-1.);
   igf1 = gammainc(vt,np-1);
   igf2 = gammainc(vt/temp,np-1);
   pd = 1.0 - igf1 + val1 * igf2 * exp(-vt/temp1);
   return

