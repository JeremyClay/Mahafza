%Use this program to reproduce Figures 3.10 through 3.13 of textbook.
clear all
close all
eps = 0.001;
N = 32;
win_rect (1:N) = 1;
win_ham = hamming(N);
win_han = hanning(N);
win_kaiser = kaiser(N, pi);
win_kaiser2 = kaiser(N, 5);
Yrect = abs(fft(win_rect, 256));
Yrectn = Yrect ./ max(Yrect);
Yham = abs(fft(win_ham, 2562));
Yhamn = Yham ./ max(Yham);
Yhan = abs(fft(win_han, 256));
Yhann = Yhan ./ max(Yhan);
YK = abs(fft(win_kaiser, 256));
YKn = YK ./ max(YK);
YK2 = abs(fft(win_kaiser2, 256));
YKn2 = YK2 ./ max(YK2);
figure (1)
plot(20*log10(Yrectn+eps),'k')
xlabel('Sample number')
ylabel('20*log10(amplitude)')
axis tight
grid
figure(2) 
plot(20*log10(Yhamn + eps),'k')
xlabel('Sample number')
ylabel('20*log10(amplitude)')
grid
axis tight
figure (3)
plot(20*log10(Yhann+eps),'k')
xlabel('Sample number'); ylabel('20*log10(amplitude)'); grid
axis tight
figure(4)
plot(20*log10(YKn+eps),'k')
grid
hold on 
plot(20*log10(YKn2+eps),'k--')
xlabel('Sample number'); ylabel('20*log10(amplitude)')
legend('Kaiser par. = \pi','Kaiser par. =5') 
axis tight
hold off