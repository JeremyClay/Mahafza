function pd = pd_swerling3 (nfa, np, snrbar)
% This function is used to calculate the probability of detection
% for Swerling 2 targets.
% Inputs
    % nfa       == false alarm number
    % np        == number of pulses
    % snrbar    == SNR
% Outputs
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
temp1 = vt / (1.0 + 0.5 * np *snrbar);
temp2 = 1.0 + 2.0 / (np * snrbar);
temp3 = 2.0 * (np - 2.0) / (np * snrbar);
ko = exp(-temp1) * temp2^(np-2.) * (1.0 + temp1 - temp3);
if (np <= 2)
   pd = ko;
   return
else
   ko = exp(-temp1) * temp2^(np-2.) * (1.0 + temp1 - temp3);
   temp4 = vt^(np-1.) * exp(-vt) / (temp1 * (factorial(np-2.)));
   temp5 =  vt / (1.0 + 2.0 / (np *snrbar));
   pd = temp4 + 1.0 - gammainc(vt,np-1.) + ko * gammainc(temp5,np-1.);
end
return

