function [rcs_db] = rcs_ellipsoid (a, b, c, phi)
% This program computes the back-scattered RCS for an ellipsoid.
% The angle phi is fixed, while the angle theta is varied from 0-180 deg.
% Inputs
    % a     == ellipsoid a-radius in meters
    % b     == ellipsoid b-radius in meters
    % c 	== ellipsoid c-radius in meters
    % phi	== ellipsoid roll angle in degrees
%Output
    % rcs   == ellipsoid rcs versus aspect angle in dBsm
eps = 0.00001;
sin_phi_s = sin(phi)^2;
cos_phi_s = cos(phi)^2;
% Generate aspect angle vector
theta = 0.:.05:180;
theta = (theta .* pi) ./ 180.;
if(a ~= b & a ~= c)
   rcs = (pi * a^2 * b^2 * c^2) ./ (a^2 * cos_phi_s .* (sin(theta).^2) + ...
   b^2 * sin_phi_s .* (sin(theta).^2) + ...
   c^2 .* (cos(theta).^2)).^2 ;
else
   if(a == b & a ~= c)
      rcs = (pi * b^4 * c^2) ./ ( b^2 .* (sin(theta).^2) + ...
         c^2 .* (cos(theta).^2)).^2 ;
   else
      if (a == b & a ==c)
         rcs = pi * c^2;
      end
   end
end
rcs_db = 10.0 * log10(rcs);
return

    