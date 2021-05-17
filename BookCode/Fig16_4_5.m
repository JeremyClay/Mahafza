% Figures 16.4 and 16.5
clc;
close all; 
clear all
N = 501;
mu = 0.1; % convergence parameter
Mu = num2str(mu);
L = 20; % FIR filter order
B = zeros(1,L+1); % FIR coefficients
sigma = 2; %Initial estimate for noise power
alpha = .100; % forgetting factor
Alpha =num2str(alpha);
k = 1:N;
noise = rand(1, length(k)) - .5; % Random noise
D = sqrt(2)*sin(2*pi*k/20); 
X = D + sqrt(7)*noise;
Y = LMS(X, D, B, mu, sigma, alpha);
subplot(3,1,1)
plot(D,'linewidth',1.5); 
xlim([0 501]); 
grid on; 
ylabel('\bfDesired response'); 
title(['\mu = ',[Mu],  ' ,   \alpha = ',[Alpha]])
subplot(3,1,2)
plot(X,'linewidth',1);
xlim([0 501]); grid on; 
ylabel('\bfCorrupted signal')
subplot(3,1,3)
plot(Y,'linewidth',1.5); 
xlim([0 501]); 
grid on; 
xlabel('\bftime in sec'); 
ylabel('\bfLMS output')