function impr_of_np = improv_fac (np, pfa, pd)
% This function computes the non-coherent integration improvment
% factor using the empirical formula defind in Eq. (13.10)
% Inputs
    % np        == number of pulses
    % pfa       == probability of false alaram
    % pd        == probability of detection
%
% Output
    % impr_of_np    == improvement factor for np pulses
fact1 = 1.0 + log10( 1.0 / pfa) / 46.6;
fact2 = 6.79 .* (1.0 + 0.253 .* pd);
fact3 = 1.0 - 0.14 .* log10(np) + 0.0183 .* (log10(np)).^2;
impr_of_np = fact1 .* fact2 .* fact3 .* log10(np);
end