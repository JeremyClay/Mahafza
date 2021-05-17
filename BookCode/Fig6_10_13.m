% Use to reproduce Figs 6.8 trhough 6.10 of textbook
clc
close all
clear all
% Figure 8
uinput = [1 1 1 1 1 -1 -1 1 1 -1 1 -1 1];
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
%Figure 6.9
uinput = [1 1 1 -1 -1 1 -1 ];
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
%Figure 6.10
uinput = [1 1 1 -1 1 1 1 1 -1 1 -1 -1 -1 1 -1 1 1 1 -1 1];
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
