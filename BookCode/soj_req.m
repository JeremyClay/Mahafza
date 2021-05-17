function [BR_range] = soj_req (pt, g, sigma, b, freq, loss, range, ...
   pj, bj,gj, lossj, gprime, rangej)
% This function implements Eqs. (257) and (2.58) of textbook
%
% Inputs
        % pt        == radar peak power in Watts
        % g         == radar antenna gain in dB
        % sigma     == target RCS in sdBsm 
        % freq      == radar operating frequency in Hz
        % tau       == radar pulse width in seconds
        % loss      == radar losses in dB
        % range     == range to target in Km
        % pj        == jammer power in Watts
        % bj        == jammer bandwidth in Hz
        % gj        == jammer antenna gain in dB
        % loosj     == jammer losses in dB
        % gprime    == jammer antenna gain
        % rangej    == range to jammer in Km
%
% Outputs
        % BR_Range  == burn through range in Km
%
c = 3.0e+8;
lambda = c / freq;
lambda_db = 10*log10(lambda^2);
if (loss == 0.0)
   loss = 0.000001;
end
if (lossj == 0.0)
   lossj =0.000001;
end
sigmadb = 10*log10(sigma);
range_db = 10*log10(range * 1000.);
rangej_db = 10*log10(rangej * 1000.);
pt_db = 10*log10(pt);
b_db = 10*log10(b);
bj_db = 10*log10(bj);
pj_db = 10*log10(pj);
factor = 10*log10(4.0 *pi);
BR_range = ((pt * 10^(2.0*g/10) * sigma * bj * 10^(lossj/10) * ...
   (rangej)^2) / (4.0 * pi * pj * 10^(gj/10) * 10^(gprime/10) * ...
   b * 10^(loss/10)))^.25 / 1000. 
end



      
