function adaptive_array_lms(N, dol,tagt_angle, jam_angle)
% This function implements the adaptive array LMS algorithm described in
% Section 16.6 of text.
% This function calls two other function
    % la_sampled_wave  and
    % linear_array_FFT
% Inputs
    % N         == size of linear array
    % dol       == array element spacing in lambda units
    % tgt_angle == targte angle (desired signal) in degrees
    % jam_angle == jammer angle (desired location of null) in degrees
% Outputs
    % This function will display the before and after normalized array
    % response in dB versus scan angle in degrees
clc
close all
mu = [0 0]; % noise mean value
sigma = [.21 .21; .21 .210]; % noise variance
% N = 19;
% dol = 0.5;
% 
% tgt_angle = 0; 
% jam_angle = 40;
sine_tgt_angle = sin(tagt_angle *pi/180);
sine_jam_angle = sin(jam_angle*pi/180);
al = la_sampled_wave(N, dol, sine_tgt_angle);
jl  = la_sampled_wave(N, dol, sine_jam_angle);
x = al + jl;
n = mvnrnd(mu,sigma,N);
jl = jl + complex(n(:,1),n(:,2));
Xl = jl * jl';
Cl = cov(Xl) + eye(N);
Wl = inv(Cl) * al;
[G, R, u, theta] = linear_array_FFT(Wl, dol);
[G1, R1, u, theta] = linear_array_FFT(x, dol);
u_deg = asin(u) *180/pi;
plot(u_deg, 10*log10(G)','linewidth', 1.5);
grid on
hold on
plot(u_deg, 10*log10(G1),'k:','linewidth', 2);
xlabel('\bfscan angle, \theta in degrees')
ylabel('\bf normalized array response')
legend('Adaptive array response','Input response')
JAM = num2str(jam_angle);
title (['null placed at \theta = ',[JAM],'^0'])

   
