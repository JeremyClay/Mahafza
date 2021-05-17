function [deltaR, Rm, Rt] = refraction(Rmax, el,H, No, Ce, pmax, hm, f)
% Compute the apparent range, range error, and the time delay due to
% refraction; Implements a stratified atmospheric refraction model.
%
% Inputs:   
       % Rmax       == true range maximum (km)
       % el         == true initial elevation angle (deg)
       % H          == height scale factor in km
       % No         == refractivity at earth surface
       % Ce         == constant im km^-1
       % pmax       == maximum electron density at hm
       % hm         == height for maximum electron contents in Kmkm
       % f          == hz, center frequency
%
% Outputs:  
    % deltaR        == range error (m)
    % Rm            == apparent range (m)
    % Rt            == time delay (sec)

% initizlize some variables
c = 299792.458;     % km/s, speed of light
Re = 6375;          % km, Earth equatorial radius

% compute object altitude using the law of cosines
hmax = sqrt(Re^2 + Rmax^2 - 2*Re*Rmax*cosd(90 + el)) - Re;

% compute the distance from Earth's center to top of each stratified layer
alt = linspace(0, hmax, ceil(hmax));
r = Re + alt;

% get the altitude indices for both the troposphere and ionosphere
Tindx = find(alt <= 50);
Iindx = find(alt > 50);

% compute the index of refraction for each layer
Ntropo = No * exp(-Ce * alt(Tindx));    % eqn 8.7
z = (alt(Iindx) - hm)/H;                % eqn 8.11
pe = pmax * exp((1-z-exp(-z))/2);       % eqn 8.10
Niono = -40.3 * pe * 1e6 / f^2;         % eqn 8.16
n = 1 + 1e-6*[Ntropo, Niono];           % eqn 8.4

% compute Bm from eqn 8.31 in degrees
Bm = el;
for k = 2:length(alt)-1
    j = k - 1;
    Bm(k) = acosd(cosd(Bm(j)).*n(j).*r(j)./n(k)./r(k));
end

% compute Am from eqn 8.32 in degrees
rm = r(1:end-1);
rmp1 = r(2:end);
Am = asind(cosd(Bm).*rm./rmp1);

% compute Theta from eqn 8.35 in degrees
theta = 90 - Bm - Am;

% compute Rom from eqn 8.34 in km
Rom = sqrt(Re^2 + rmp1.^2 - 2*Re*rmp1.*cosd(cumsum(theta)));

% compute Rm from from eqn 8.44 in km
Rm = sqrt(rm.^2 + rmp1.^2 - 2*rm.*rmp1.*cosd(theta));

% compute deltaR from eqns 8.43 & 8.47 in km
nR = [n(Tindx).*Rm(Tindx), Rm(Iindx(1:end-1))./n(Iindx(1:end-1))];
deltaR = cumsum(nR) - Rom;

% compute the time delay in seconds
tT = sum(nR) / c;       % eqns 8.41, 8.46
toM = Rom / c;          % eqn 8.42 
Rt = tT - toM(end);

return
