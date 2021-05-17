function [LL, sintheta, wd] = stap_smaa(sintheta_t1, wd_t1, sintheta_t2, wd_t2);

do_plot = 1;

N = 10; Na = 2*N-1;
M = 12;
No = 250;

beta = 1;
dol = 0.5;

CNR = 20; % dB
SNR = 0; % dB
JSR = 20; % dB

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
Rc = zeros(Na*M);
ac_all = zeros(Na*M,1);
for k = 1: length(phi),
    ac = sigma_c * smaa_st_steering_vector(phi(k), N, beta*phi(k), M);
    Rc = Rc + ac * ac';
    ac_all = ac_all + ac;
end
Rc = Rc / length(phi);


% Noise signals decorrelate from pulse-to-pulse
% With this assumption, noise covariance matrix is
Rn = sigma2_n * eye(M*Na);


% Target 1 covariance matrix
% at1 = smaa_st_steering_vector(sintheta_t1, N, wd_t1, M);
% Rt1 = sigma2_t1 * at1 * at1';
at1 = sigma_t1 * smaa_st_steering_vector(sintheta_t1, N, wd_t1, M);
Rt1 = at1 * at1';


% Target 1 covariance matrix
% at2 = smaa_st_steering_vector(sintheta_t2, N, wd_t2, M);
% Rt2 = sigma2_t2 * at2 * at2';
at2 = sigma_t2 * smaa_st_steering_vector(sintheta_t2, N, wd_t2, M);
Rt2 = at2 * at2';


% Total covariance matrix
R = Rc + Rn + Rt1 + Rt2;


% Unweighted spectrum of the total return from the beamformer
sintheta = linspace(-1, 1);
wd = beta * sintheta;
Pb = zeros(length(wd), length(sintheta));
for nn = 1: length(sintheta),
    for mm = 1: length(wd),
        a = smaa_st_steering_vector(sintheta(nn), N, wd(mm), M);
        Pb(mm, nn) = a' * R * a;
    end
end

if do_plot,
    % Display the total return spectrum
    figure (5)
    imagesc(sintheta, wd, 10*log10(abs(Pb)))
    set(gca,'ydir','normal'), xlabel('sine angle'), ylabel('normalized doppler')
    figure (6)
    surf(sintheta, wd, 10*log10(abs(Pb)))
    shading interp, xlabel('sine angle'), ylabel('normalized doppler')
end


% Calculate optimal weights
Rc = (ac_all * ac_all') / length(phi);
Rinv = inv(Rc + Rn);
wopt = Rinv * (at1 + at2);


% Log-Likelihood Function
sintheta = linspace(-1, 1);
wd = beta * sintheta;
LL = zeros(length(wd), length(sintheta));
for nn = 1: length(sintheta),
    for mm = 1: length(wd),
        a = smaa_st_steering_vector(sintheta(nn), N, wd(mm), M);
        LL(mm,nn) = abs( a' * Rinv * (at1+at2+ac_all) )^2 / ( a' * Rinv * a );
    end
end
