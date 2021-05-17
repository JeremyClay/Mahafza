function [ambig] = ambiguity_code(uinput)
% Compute ambiguity surface for any input code using the algorithm described 
% Section 6.5 of textbook. 
%
% Compute code length N
N = size(uinput,2);
% set code length to tau
tau = N;
code = uinput;
samp_num = size(code,2) * 10;
% compute the next power integer of 2 for FFT purposes
n = ceil(log(samp_num) / log(2));
% compute FFT size, nfft
nfft = 2^n;
% set a dummy array in preperation for interpolation
u(1:nfft) = 0;
j = 0;
% perform interpolation to next integer power of 2
for index = 1:10:samp_num
    index;
    j = j+1;
    u(index:index+10-1) = code(j);
end
% set up the array v for frequency shifts
v = u;
% set up how many delay cuts to compute
delay = linspace(-tau,tau,nfft);
% set up how many frequency cuts, the value 12 is arbitrary can be any
% even integer larger or equal to 2
freq_del = 12 / tau /100;
j = 0;
vfft = fft(v,nfft);
% perform successive FFT calculation cuts
for freq = -6/tau:freq_del:6/tau;
    j = j+1;
    exf = exp(sqrt(-1) * 2. * pi * freq .* delay);
    u_times_exf = u .* exf;
    ufft = fft(u_times_exf,nfft);
    % Ambiguity surface is computed as inverse FT of array ufft
    prod = ufft .* conj(vfft);
    ambig(j,:) = fftshift(abs(ifft(prod))');
end
