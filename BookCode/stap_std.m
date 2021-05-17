function [LL, sintheta, wd] = stap_std(sintheta_t1, wd_t1, sintheta_t2, wd_t2);

do_plot = 1;

N = 10;         % Sensors 
M = 12;         % Pulses
No = 250;       % k-th clutter bins (refers to fig. 5)

beta = 1;       % The way the clutter fills the angle Doppler
dol = 0.5;      % d over lambda

CNR = 30;   % dB Clutter to Noise Ratio  
SNR = 10;    % dB Signal to Noise Ratio 
JSR = 0;   % dB Jammer to Signal Ratio

% Set the noise power
sigma2_n = 1;

% Clutter power
sigma2_c = sigma2_n * 10^(CNR/10);
sigma_c = sqrt(sigma2_c);

% Target 1 power
sigma2_t1 = sigma2_n * 10^(SNR/10);
sigma_t1 = sqrt(sigma2_t1);

% Target 2 (Jammer) power
sigma2_t2 = sigma2_t1 * 10^(JSR/10);
sigma_t2 = sqrt(sigma2_t2);



% Ground clutter is the primary source of interference
sintheta = linspace(-1, 1, No);
phi = 2 * dol * sintheta;
wd = beta * phi;
Rc = zeros(N*M);
ac_all = zeros(N*M,1);
for k = 1: length(phi),
    ac = sigma_c * st_steering_vector(phi(k), N, beta*phi(k), M);  % Xc
    Rc = Rc + ac * ac';    % covarience matrix of target "1" ,  "'" --> conjugate transpose
    ac_all = ac_all + ac;  % "w" not optimized yet 
end
Rc = Rc / length(phi);   


% Noise signals decorrelate from pulse-to-pulse
% With this assumption, noise covariance matrix is
Rn = sigma2_n * eye(M*N);


% Target 1 covariance matrix
% at1 = st_steering_vector(sintheta_t1, N, wd_t1, M);
% Rt1 = sigma2_t1 * at1 * at1';
at1 = sigma_t1 * st_steering_vector(sintheta_t1, N, wd_t1, M); % Xj1
Rt1 = at1 * at1';   % covarience matrix of target "1"


% Target 2 covariance matrix (may represnt a jammer)
% at2 = st_steering_vector(sintheta_t2, N, wd_t2, M);
% Rt2 = sigma2_t2 * at2 * at2';
at2 = sigma_t2 * st_steering_vector(sintheta_t2, N, wd_t2, M);
Rt2 = at2 * at2';  % covarience matrix of target "2"


% Total covariance matrix
R = Rc + Rn + Rt1 + Rt2;


% Unweighted spectrum of the total return from the beamformer
sintheta = linspace(-1, 1);
wd = beta * sintheta;
Pb = zeros(length(wd), length(sintheta));
for nn = 1: length(sintheta),
    for mm = 1: length(wd),
        a = st_steering_vector(sintheta(nn), N, wd(mm), M);
        Pb(mm, nn) = a' * R * a;
    end
end

if do_plot,
    % Display the total return spectrum
    figure (1)
    imagesc(sintheta, wd, 10*log10(abs(Pb)))
    colorbar
    title('Total Return spectrum before STAP Detection of target, clutter, noise & jammer');
    set(gca,'ydir','normal'), xlabel('sine angle'), ylabel('normalized doppler')
    figure (2)
    surf(sintheta, wd, 10*log10(abs(Pb)))
    shading interp, , xlabel('sine angle'), ylabel('normalized doppler')
    title('Total Return spectrum before STAP Detection of target, clutter, noise & jammer');
end

% Total covariance matrix
R = Rc + Rn + Rt1 + Rt2;

% Calculate optimal weights
Rc = (ac_all * ac_all') / length(phi);

% Rinv = inv(Rc + Rn);  % Original by Keith
% wopt = Rinv * (at1 + at2);% Original by Keith

 Rinv = inv(Rc + Rn );  % our expectation
wopt = Rinv' * (at1 + at2 );  % our expectation


% Log-Likelihood Function
% Calculating the SNR and swiching to the run_stap.m to execute the log part

sintheta = linspace(-1, 1);
wd = beta * sintheta;
LL = zeros(length(wd), length(sintheta));
for nn = 1: length(sintheta),
    for mm = 1: length(wd),
        a = st_steering_vector(sintheta(nn), N, wd(mm), M);
    %    LL(mm,nn) = abs( a' * Rinv * (at1+at2+ac_all) )^2 / ( a' * Rinv * a ); % Original by Keith
       LL(mm,nn) = abs(a' * Rinv * (at1+at2+ac_all)  )^2 / ( a' * (Rc + Rn ) * a ); % our expectation
    end
end
disp(size(a))
disp (size(Rinv))
