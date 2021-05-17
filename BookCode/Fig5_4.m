% Use this program to reproduce Fig 5.4 of text
close all
clear all
eps = 0.0001;
taup = 3.;
fd = -10./taup:.001:10./taup;
uncer = abs( sinc(taup .* fd));
figure(2)
plot (fd, uncer,'k','linewidth',1);
xlabel ('Frequency - Hz')
ylabel ('Ambiguity - Volts')
grid



      