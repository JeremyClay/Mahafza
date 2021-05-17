function [deltaR, Ra, Rt] = refractivity (ce, N0, hm, f, beta0, rhomax, H, Rfs)
%This function computes the range error due to refraction
%
% Inputs
    % ce        == constant in Km^-1
    % N0        == Refractivity at the earth surface
    % hm        == height of maximum electron density in Km
    % freq      == radar operating frequency in Hz
    % beta0     == initial elevation angle in degrees
    % rhomax    == maximum ionization in the inonosphere in Columbs
    % H         == constant
    % Rfs        == maximum target height in Km
%
% Output
    % delatR    == range error array in meters
    % Ra        == apparent target range array in Km
    % Rt        == true target range array in Km
%
format long
% constants
M = 10; % number of layers in stratified atmosphere
%c = 3e8; % speed of light
r0 = 6375; % earth radius
Q = 1.6022e-19; % charge of an electron
k = 1.39e-23; % Boltzman's constant
% compute the hm array
Rfs
angle = (pi/2) +  beta0
r = sqrt( Rfs^2 + r0^2 - 2 * Rfs * r0 * cos(angle))
ht = r - r0
totaltheta = asin(sin(angle) *Rfs /r)
h = linspace(2,ht,M); % use minimum range at surface as 2 meters
deltah = ht/(M);
% compute the rm array; Eq. (8.28)
rm = zeros(1,M+1);
m = 2;
rm(1) = r0;
while m <= M+1
    rm(m) = rm(m-1) + deltah;
    m = m + 1;
end
marker = find(h <=50);
% compute index of refraction in troposphere
N = N0 .* exp(-ce.*h(marker));
n(marker) = N .* (10^-6) + 1;
% compute index of refraction in ionosphere
marker = find(h>50);
z = (h(marker) - hm) ./ H;
rhoe = rhomax .* exp(.5 .*(1-z-exp(-z)));
n(marker) = 1 - (40.3 .*rhoe )./ (f*f);
% compute angles beta_m Eq. (8.31)
betam = zeros(1,M);
betam(1) = beta0;
m = 2;
while m <= M
    betam(m) = acos(((n(m-1) * rm(m))/(n(m) * rm(m+1))) * cos(betam(m-1)));
    m = m + 1;
end
% compute alpha_m Eq. *8.32)
alpham = zeros(1,M);
m = 1;
while m <= M
    alpham(m) = asin((rm(m)/rm(m+1)) * cos(betam(m)));
    m = m + 1;
end
% compute angle thetam Eq. (8.35)
thetam = (pi/2) - betam - alpham;
thetam (end)*180/pi
% compute succssive thetam sums
thetamsum = zeros(1,M);
% compute free range Eq. (8.22)
for m = 1:M
    thetasum(m) = sum(thetam(1:m));
end
thetasum(end)
R = sqrt(rm(1)^2 + rm(M+1)^2 - 2 * rm(1) * rm(M+1) * cos(thetasum(M)));
% compute ranges R0m Eq. (8.34)
Rom = zeros(1,M);
m = 1;
while m <= M
    Rom(m) = sqrt(rm(1)^2 + rm(m+1)^2 - 2 * rm(1) * rm(m+1) * cos(thetasum(m)));
    m = m + 1;
end
% compute angles beta0m Eq. (8.33);
m = 1;
while m <= M
    betaom(m) = acos((rm(m+1)/Rom(m)) * cos(thetam(m)));
    m = m + 1;
end
% compute apparent ranges Ra
Ra = zeros(1,m);
Ra(1) = Rom(1); 
m = 2;
while m <= M
    Ra(m) = Ra(m-1) + Rom(m);
    m = m + 1;
end
% Compute segemnts of stratified atmosphere free space range
Rtm = zeros(1,M);
for m = 1 : M
    Rtm(m) = sqrt(rm(m)^2 + rm(m+1)^2 - 2 * rm(m) * rm(m+1) * cos(thetam(m)));
    deltaRm(m) = n(m) * Rtm(m)  - Rom(m);
end
% Rt = zeros(1,M);
% for m = 1:M
%     deltaR(m) = sum(deltaRm(1:m));
%     Rt(m) = sum(Rtm(1:m));
% end

plot( Rom./1000,deltaRm )
grid
end

