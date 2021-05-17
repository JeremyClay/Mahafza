function [BR_range] = ssj_req (pt, g, freq, sigma, br, loss, ...
   pj, bj, gj, lossj)
% This function implements Eq.s (2.50) and Eq. (2.52). It also generates
% plot 2.7a
% 
% Inputs
        % pt        == radar peak power in Watts
        % g         == radar antenna gain in dB
        % freq      == radar operating frequency in Hz
        % sigma     == target RCS in squared meters
        % br        == radar bandwidth in Hz
        % loss      == radar losses in dB
        % pj        == jammer power in Watts
        % bj        == jammer bandwidth in Hz
        % gj        == jammer antenna gain in dB
        % loosj     == jammer losses in dB
%
% Outputs
        % BR_range  == cross over range in Km
        
c = 3.0e+8;
lambda = c / freq;
lambda_db = 10*log10(lambda^2);
if (loss == 0.0)
   loss = 0.000001;
end
if (lossj == 0.0)
   lossj =0.000001;
end
sigmadb =10*log10(sigma);
pt_db = 10*log10(pt);
b_db = 10*log10(br);
bj_db = 10*log10(bj);
pj_db = 10*log10(pj);
factor = 10*log10(4.0 *pi);
BR_range = sqrt((pt * (10^(g/10)) * sigma * bj * (10^(lossj/10))) / ...
   (4.0 * pi * pj * (10^(gj/10)) * br * ...
   (10^(loss/10)))) / 1000.0  
s_at_br = pt_db + 2.0 * g + lambda_db + sigmadb - ...
      3.0 * factor - 4.* 10*log10(BR_range) - loss 
index =0;
for ran_var = .1:10:10000
   index = index + 1;
   ran_db = 10*log10(ran_var * 1000.0);
   ssj(index) = pj_db + gj + lambda_db + g + b_db - 2.0 * factor - ...
      2.0 * ran_db - bj_db - lossj + s_at_br ;
   s(index) = pt_db + 2.0 * g + lambda_db + sigmadb - ...
      3.0 * factor - 4.* ran_db - loss + s_at_br ;
end
ranvar = .1:10:10000;
ranvar = ranvar ./ BR_range;
semilogx (ranvar,s,'k',ranvar,ssj,'k-.');
axis([.1 1000 -90 40])
xlabel ('Range normalized to cross-over range');
legend('Target echo','SSJ')
ylabel ('Relative signal or jamming amplitude - dB');
grid




      
