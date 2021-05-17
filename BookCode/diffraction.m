function F = diffraction(freq, hr, ht,R,nt);
%   Generalized spherical earth propagation factor calculations
%   After Shatz: Michael, P. Shatz, and George, H. Polychronopoulos, An
%   algorithm for Elevation of Radar Propagation in the Spherical Earth 
%   Diffraction Region. IEEE Transactions on Antenna nd Propagation, 
%   VOL. 38, NO.8, August 1990.
format long
re = 6373e3 * (4/3); % 4/3 earth radius in Km
[an] = airyzo1(nt);% calculate the roots of teh Airy function
c = 3.0e8; % speed of light
lambda = c/freq; % wavelength
r0 = (re*re*lambda / pi)^(1/3);
h0 = 0.5 * (re*lambda*lambda/pi/pi)^(1/3);
y = hr / h0;
z = ht / h0;
%%%%%%%%%%%%
par1 = exp(sqrt(-1)*pi/3);
pary1 = ((2/3).*(an + y .* par1).^(1.5));
    pary = exp(pary1);
    parz1 = ((2/3).*(an + z .* par1).^(1.5));
    parz = exp(parz1);
    f1n = airy(an + y * par1) .* airy(an + z * par1) .* pary .*parz ;
    f1d = par1 .* par1 .* airy(1,an) .* airy(1,an);
    f1 = f1n ./ f1d;
    index = find(f1<1e6);
%%%%%%%%%%%%
F = zeros(1,size(R,2));
for range = 1:size(R,2)
    x(range) = R(range)/r0;
    f2 = exp(0.5 .* (sqrt(3) +sqrt(-1)) .*an.*x(range) - pary1 -parz1);
    victor = f1(index) .* f2(index);
    fsum = sum(victor);
    F(range) = 2 .*sqrt(pi.*x(range)) .* fsum;
end