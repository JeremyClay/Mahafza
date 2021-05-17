% This program computes the monostatic RCS for a frustum.
% Incident linear Polarization is assumed.
% To compute RCP or LCP RCS one must use Eq. (2.24)
% When viewing from the small end of the frustum
% normal incedence occurs at aspect pi/2 - half cone angle
% When viewing from the large end, normal incidence occur at
% pi/2 + half cone angle.
% RCS is computed using Eq. (2.43). This program assumes a geomtry
% similar top Fig. 2.13
clear all
format long
index = 0;
eps = 0.000001;
lambda = 3.0e+8 /10e+9;
% Enter frustum's small end radius
r1 =.02057;
% Enter Frustum's large end radius
r2 = .05753;
% Compute Frustum's length
h = .20945;
% Comput half cone angle, alpha
alpha = atan(( r2 - r1)/h);
% Compute z1 and z2
z2 = r2 / tan(alpha);
z1 = r1 / tan(alpha);
delta = (z2^1.5 - z1^1.5)^2;
factor = (8. * pi * delta) / (9. * lambda);
   % Compute normal incidence, large end
   normal_incedence = (180./pi) * ((pi /2) + alpha)
   % Compute RCS from zero aspect to normal inicedence
   for theta = 0.001:.1:normal_incedence-.5
      index = index +1;
      theta = theta * pi /180.;
      rcs1(index) = (lambda * z1 * tan(alpha) *(tan(theta - alpha))^2) / ...
         (8. * pi *sin(theta)) + eps;
   end
   %Compute broadside RCS
   index = index +1;
   rcs_normal = factor * sin(alpha) / ((cos(alpha))^4) + eps;
   rcs1(index) = rcs_normal;
   % Compute RCS from broad side to 180 degrees 
   for theta = normal_incedence+.5:.1:180
      index = index + 1;
      theta =  theta * pi / 180. ;
      rcs1(index) = (lambda * z2 * tan(alpha) *(tan(theta - alpha))^2) / ...
         (8. * pi *sin(theta)) + eps;
   end
   % Compute normal incedence, small end
   normal_incedence = (180./pi) * ((pi /2) - alpha)
   % Compute RCS from zero aspect to normal inicedence (large end of frustum)
   index2 =0;
   for theta = 0.001:.1:normal_incedence-.5
      index2 = index2 +1;
      theta = theta * pi /180.;
      rcs2(index2) = (lambda * z1 * tan(alpha) *(tan(theta + alpha))^2) / ...
         (8. * pi *sin(theta)) + eps;
   end
   %Compute broadside RCS
   index2 = index2 +1;
   rcs_normal = factor * sin(alpha) / ((cos(alpha))^4) + eps;
   rcs2(index2) = rcs_normal;
   % Compute RCS from broad side to 180 degrees (small end of frustum)
   for theta = normal_incedence+.5:.1:180
      index2 = index2 + 1;
      theta =  theta * pi / 180. ;
      rcs2(index2) = (lambda * z2 * tan(alpha) *(tan(theta + alpha))^2) / ...
         (8. * pi *sin(theta)) + eps;
   end
end
% Plot RCS versus aspect angle
delta = 180 /index;
angle = 0.001:delta:180;
subplot(2,1,1)
plot (angle,10*log10(rcs1),'k');
grid;
xlabel ('Apsect angle - degrees');
ylabel ('RCS - dBsm');
title  ('Wavelength = 0.861 cm')
 subplot(2,1,2)
plot (angle,10*log10(rcs2),'k');
grid;
xlabel ('Apsect angle - degrees');
ylabel ('RCS - dBsm');
