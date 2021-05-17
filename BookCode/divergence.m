function [D] = divergence(r1, r2, ht, hr, psi)
% calculates divergence
% Inputs
    % r1        == ground range between radar and specular point in Km	
    % r2        == ground range between specular point and target in Km
    % hr        == radar height in meters	
    % ht        == target height in meters	
    % psi       == grazing angle in degrees
% Output
    % D         == divergence 
%
psi = psi .* pi ./180; % psi in radians
re = (4/3) * 6375e3;
r = r1 + r2;
arg1 = re.* r .* sin(psi) .*cos(psi);
arg2 = ((2.*r1.*r2./cos(psi)) + re.*r.*sin(psi)) .* ...
    (1+hr./re) .* (1+hr./re);
D = sqrt(arg1 ./ arg2);
return