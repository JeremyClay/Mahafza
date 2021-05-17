function Sr = surf_rough(hrms, freq, psi)
clight = 3e8;
psi = psi .* pi ./ 180; % angle in radians
lambda = clight / freq; % wavelength
g = (2.* pi .* hrms .* sin(psi) ./ lambda).^2;
Sr = exp(-2 .* g);
return