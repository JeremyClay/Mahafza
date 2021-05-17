% Use this program to reproduce Fig. 5.15 of text
clear all
close all
delw = linspace(-.5,.5,75);
T1 = .5 .* sin(pi.*delw);
T2 = delw + (1/2/pi) .* sin(2*pi.*delw);
T3 = .25 .* (sin(pi.*delw)) .* ((cos(pi.*delw)).^2 + 2);
T4 = delw + (1/2/pi) .* sin(2*pi.*delw) + (2/3/pi) .* (cos(pi.*delw)).^3 .* sin(delw);
figure (1)
plot(delw,T1,'k*',delw,T2,'k:',delw,T3,'k.',delw,T4,'k');
grid
ylabel('Group delay function')
xlabel('\omega/B')
legend('n=1','n=2','n=3','n=4')