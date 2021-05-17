clear all

bandwidth = 10e6;
center_freq = 9.5e9;
window = 1;
range_bins = 1024;
num_targets = 3;
target_range = [200.0, 2000.0, 4000.0];
target_rcs = [25.0, 10.0, 25.0];

range_window = 5000;
a2drate = 20e6;
pulsewidth = 10.0e-6;

time_bandwidth = pulsewidth*bandwidth
c = 3.0e8;

replica_samples = fix(a2drate*pulsewidth)

sample_interval = 1.0/a2drate;

range_window_time = 2*range_window/c + pulsewidth

accumulator_samples = fix(a2drate * range_window_time)

range_samples = accumulator_samples - replica_samples

scalef = range_bins / range_samples

fftsize = fix(scalef * accumulator_samples)


window_size = replica_samples;
window = zeros(1,window_size);

% hamming window
sum = 0.0;
if window == 0
    factor = 2.0 * pi / (window_size - 1);
    for k = 0:window_size-1
        window(k+1) = 0.54 - 0.46*cos(factor*k);
    sum = sum + window(k+1);
    end
    sum = scalef/sum;
    for k = 0:window_size - 1
        window(k+1) = window(k+1)*sum;
    end
end
    
    % hamming window
sum = 0.0;
if window == 1
    factor = 2.0 * pi / (window_size - 1);
    for k=0:window_size - 1 
        window(k+1) = 0.42 - 0.5*cos(factor*k) + 0.08*cos(2*factor*k);
    sum = sum + window(k+1);
    end
    sum = 1.0/sum;
    for k = 0:window_size-1
        window(k+1) = window(k+1)*sum;
    end
end

%t_replica = linspace(-0.5*pulsewidth, 0.5*pulsewidth, replica_samples);
t_replica = linspace(0, pulsewidth, replica_samples);

replica = zeros(1, accumulator_samples);

for k = 1:replica_samples
    replica(k) = window(k)*exp(i * pi * (bandwidth/pulsewidth) .* t_replica(k).^2);
end

figure(1)
clf
subplot(2,2,1)
plot(real(replica))

%replica = window .* replica;
replica = fft(replica);
%replica = fft(replica);

subplot(2,2,2)
plot(abs(replica))

received = zeros(1,accumulator_samples);

for i_t = 1:num_targets
    
    t1 = fix(2*target_range(i_t)/(sample_interval*c)) + 1;
    t2 = t1 + replica_samples - 1;
    
    if t1 > accumulator_samples
        continue
    end
    
    if t2 < 1
        continue
    end
        
    if t1 < 1
        t1 = 1;
    end

    if t2 > accumulator_samples
        t2 = accumulator_samples;
    end
    t1
    t2
 
    m = 1;
    for k = t1:t2
       received(accumulator_samples - k + 1) = received(accumulator_samples - k + 1) + target_rcs(i_t) .* exp(-i * pi * (bandwidth/pulsewidth) * (t_replica(m)^2));
       m = m+1;
    end
end



subplot(2,2,3)
plot(real(received))

received = fft(received);
%received = fft(conj(received));



subplot(2,2,4)
plot(abs(received));



y = replica.*received;
y(:,accumulator_samples + 1:fftsize) = 0;

figure(2)
clf

subplot(1,3,1)
plot(abs(y))

out = ifft(y);

range = linspace(0.5*range_window_time*c, 0, fftsize);

subplot(1,3,2)
plot(abs(out));

out2 = out(fftsize-range_bins+1:fftsize);
%out2 = out(1:range_bins);

range2 = linspace(range_window, 0, range_bins);

subplot(1,3,3)
plot(range2, abs(out2));
