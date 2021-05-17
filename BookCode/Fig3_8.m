% use this program to reproduce Fig. 3.8 of text
clear all
close all
nscat = 2; %two point scatterers
taup = 10e-6; % 100 microsecond uncompressed pulse
b = 40.0e6; % 50 MHz bandwdith
rrec = 50 ; % 50 meter processing window
scat_range = [15 25] ; % scattterers are 15 and 25 meters into window
scat_rcs = [1 2]; % RCS 1 m^2 and 2m^2
winid = 0; %no window used
%function [y] = matched_filter(nscat,taup,b,rrec,scat_range,scat_rcs,winid)
eps = 1.0e-16;
% time bandwidth product
time_B_product = b * taup;
if(time_B_product < 5 )
    fprintf('************ Time Bandwidth product is TOO SMALL ***************')
    fprintf('\n Change b and or taup')
  return
end
% speed of light
c = 3.e8; 
% number of samples
n = fix(2 * taup * b);
% initialize input, output and replica vectors
x(nscat,1:n) = 0.;
y(1:n) = 0.;
replica(1:n) = 0.;
% determine proper window
if( winid == 0.)
   win(1:n) = 1.;
end
if(winid == 1.);
    win = hamming(n)';
end
if( winid == 2.)
    win = kaiser(n,pi)';
end
if(winid == 3.)
    win = chebwin(n,60)';
end
% check to ensure that scatterers are within recieve window
index = find(scat_range > rrec);
if (index ~= 0)
    'Error. Receive window is too large; or scatterers fall outside window'
  return
end
% calculate sampling interval
t = linspace(-taup/2,taup/2,n);
replica = exp(i * pi * (b/taup) .* t.^2);
figure(1)
plot(t,real(replica))
ylabel('Real (part) of replica')
xlabel('Time in seconds')
grid
figure(2)
plot(t,imag(replica))
ylabel('Imaginary (part) of replica')
xlabel('Time in seconds')
grid
figure(3)
sampling_interval = 1 / 2.5 /b;
freqlimit = 0.5/ sampling_interval;
freq = linspace(-freqlimit,freqlimit,n);
plot(freq,fftshift(abs(fft(replica))));
ylabel('Spectrum of replica')
xlabel('Frequency in Hz')
grid
 for j = 1:1:nscat
    range = scat_range(j) ;;
    x(j,:) = scat_rcs(j) .* exp(i * pi * (b/taup) .* (t +(2*range/c)).^2) ;
    y = x(j,:)  + y;
end
