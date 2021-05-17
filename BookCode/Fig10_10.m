%generates Fig. 10.10 of text
k = .00035/25;
a = 25*k;
b = 30*k;
c = 27*k;
d = 31*k;
v2 = linspace(0,1345,10000);
f2 = (2.*v2)/.0375;
% H1(f)
T1 = exp(-j*2*pi.*f2*a);
X1 = 1/2.*(1 - T1).*conj(1 - T1);
H1 = 10*log10(abs(X1));
% H2(f)
T2 = exp(-j*2*pi.*f2*b);
X2 = 1/2.*(1 - T2).*conj(1 - T2);
H2 = 10*log10(abs(X2));
% H3(f)
T3 = exp(-j*2*pi.*f2*c);
X3 = 1/2.*(1 - T3).*conj(1 - T3);
H3 = 10*log10(abs(X3));
% H4(f)
T4 = exp(-j*2*pi.*f2*d);
X4 = 1/2.*(1 - T4).*conj(1 - T4);
H4 = 10*log10(abs(X4));
% Plot of the four components of H(f)
figure(1)
subplot(2,1,1)
% H(f) Average
ave2 = abs((X1 + X2 + X3 + X4)./4);
Have2 = 10*log10(abs((X1 + X2 + X3 + X4)./4));
plot(v2,Have2);
axis([0 1345 -25 5]);
title('Two pulse MTI stagger ratio 25:30:27:31');
xlabel('Radial Velocity (m/s)');
ylabel('MTI Gain (dB)');
grid on
% %Mean value of H(f)
v4 = v2; 
f4 = (2.*v4)/.0375;
% H1(f)
T1 = exp(-j*2*pi.*f4*a);
T2 = exp(-j*2*pi.*f4*(a + b));
T3 = exp(-j*2*pi.*f4*(a + b + c));
X1 = 1/20.*(1 - 3.*T1 + 3.*T2 - T3).*conj(1 - 3.*T1 + 3.*T2 - T3);
H1 = 10*log10(abs(X1));
% H2(f)
T3 = exp(-j*2*pi.*f4*b);
T4 = exp(-j*2*pi.*f4*(b + c));
T5 = exp(-j*2*pi.*f4*(b + c + d));
X2 = 1/20.*(1 - 3.*T3 + 3.*T4 - T5).*conj(1 - 3.*T3 + 3.*T4 - T5);
H2 = 10*log10(abs(X2));
% H3(f)
T6 = exp(-j*2*pi.*f4*c);
T7 = exp(-j*2*pi.*f4*(c + d));
T8 = exp(-j*2*pi.*f4*(c + d + a));
X3 = 1/20.*(1 - 3.*T6 + 3.*T7 - T8).*conj(1 - 3.*T6 + 3.*T7 - T8);
H3 = 10*log10(abs(X3));
% H4(f)
T9 = exp(-j*2*pi.*f4*d);
T10 = exp(-j*2*pi.*f4*(d + a));
T11 = exp(-j*2*pi.*f4*(d + a + b));
X4 = 1/20.*(1 - 3.*T9 + 3.*T10 - T11).*conj(1 - 3.*T9 + 3.*T10 - T11);
H4 = 10*log10(abs(X4));
% H(f) Average
ave4 = abs((X1 + X2 + X3 + X4)./4);
Have4 = 10*log10(abs((X1 + X2 + X3 + X4)./4));
% Plot of H(f) Average
subplot(2,1,2)
plot(v4,Have4);
axis([0 1345 -25 5]);
title('Four pulse MTI stagger ratio 25:30:27:31');
xlabel('Radial Velocity (m/s)');
ylabel('MTI Gain (dB)');
grid on

