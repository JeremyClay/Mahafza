function [G, R, u, theta] = linear_array_FFT(a, dol);

Nelt = length(a);
ratio = 1;

if dol<=0.5,
    Nr = Nelt;
    dolr = dol;
else
    ratio = ceil(dol/0.5);
    Nr = Nelt * ratio;
    dolr = dol/ratio;
    atemp = a;
    a = zeros(1, Nr);
    a(1: ratio: Nr) = atemp(1: Nelt);
end

% use a value for NFFT that is at least 10 times that of N
% I borrowed this piece of code
nfft = 2^(ceil(log(10*Nr)/log(2)));

nfft = 65536;

A = fftshift(fft(a, nfft));

% Compute u = sin(theta)
u = [-nfft/2 : nfft/2-1] * (1/dolr/nfft);

% 'k' gives us the bounds of visible space
k = find(abs(u)<=1);

% Radiation patterns is the part in visible space
%R = (abs(A(k))).^2 / Nelt;
R = (abs(A(k))).^2;

u = u(k);
theta = asin(u);

% Gain patterns
Rbar = 0.5 * sum(R) / (nfft*dol);
G = R / Rbar;
