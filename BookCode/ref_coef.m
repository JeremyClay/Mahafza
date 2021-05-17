function [rh,rv] = ref_coef (psi, epsp, epspp)
% This function calculates the horizontal and vertical magnitude and phase 
% response of the reflection coefficient. 
%
% Inputs
    % psi       == grazing angle in degrees (a vector or a scalar)
    % epsp      == epsilon prime 
    % epspp     == epsilon double prime
% Output
    % rh        == horizontal reflection coefficient complex vector	
    % rv        == vertical reflection coefficient complex vector	
%
eps = epsp - i .* epspp; 
psirad = psi.*(pi./180.);
arg1 = eps - (cos(psirad).^2);
arg2 = sqrt(arg1);
arg3 = sin(psirad);
arg4 = eps.*arg3;
rv = (arg4-arg2)./(arg4+arg2);
rh = (arg3-arg2)./(arg3+arg2);
return
