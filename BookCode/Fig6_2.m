% Use to reproduce Fig 6.2 of textbook
clc
close all
clear all
uinput = [1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1];
[ambig] = ambiguity_code(uinput);
freq = linspace(-6,6, size(ambig,1));
N = size(uinput,2);
% set code length to tau
tau = N;
code = uinput;
samp_num = size(code,2) * 10;
% compute the next power integer of 2 for FFT purposes
n = ceil(log(samp_num) / log(2));
% compute FFT size, nfft
nfft = 2^n;
% set a dummy array in preparation for interpolation
delay = linspace(-N-2,N,nfft);
plot_figures_chap6 ( ambig, delay, freq)
