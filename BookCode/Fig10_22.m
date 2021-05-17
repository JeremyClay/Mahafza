%
clc;
clear all; 
close all;
PSD_f_hz = [1e3  1e4  1e5  1e6  10e6];
PSD_val_dBc_per_hz = [-55  -85 -105 -115  -115];
m = (PSD_val_dBc_per_hz(2:end) - PSD_val_dBc_per_hz(1:end-1))./...
		(log10(PSD_f_hz(2:end)) - log10(PSD_f_hz(1:end-1)));
constant = 10.^(PSD_val_dBc_per_hz(1:end-1)/10).* ...
		(PSD_f_hz(1:end-1).^(-m/10));

semilogx(PSD_f_hz,PSD_val_dBc_per_hz,'bo-','Linewidth',1.5);
grid on
xlabel('\bffreq, Hz'); 
ylabel('\bfPSD, dBc/Hz');
gtext('-\bf30dB/decade')
gtext('\bf-20dB/decade')
gtext('\bf-10dB/decade')
