function [Pb_linear, Pb_smaa, sintheta, wd] = stap(sintheta_t, wd_t);

N = 10;
M = 12;
No = 250;

beta = 1;
dol = 0.5;

CNR = 40; % dB
SNR = 0;  % dB

sigma2_n = 1;
sigma2_t = sigma2_n * 10^(SNR/10);
sigma2_c = sigma2_n * 10^(CNR/10);


% Clutter covariance matrix
sintheta = linspace(-1, 1, No);
phi = 2 * dol * sintheta;
wd = beta * phi;
Rc_linear = zeros(N*M);
Rc_smaa = zeros((2*N-1)*M);
for k = 1: length(phi),
    a_linear =      st_steering_vector(phi(k), N, beta*phi(k), M);
    a_smaa   = smaa_st_steering_vector(phi(k), N, beta*phi(k), M);
    Rc_linear = Rc_linear + sigma2_c * a_linear * a_linear' + sigma2_n * eye(size(Rc_linear));
    Rc_smaa   = Rc_smaa   + sigma2_c * a_smaa   * a_smaa'   + sigma2_n * eye(size(Rc_smaa));
end

% % Clutter spectrum from the beamformer output
% sintheta = linspace(-1, 1);
% wd = beta * sintheta;
% for nn = 1: length(sintheta),
%     for mm = 1: length(wd),
%         a_linear =      st_steering_vector(sintheta(nn), N, wd(mm), M);
%         a_smaa   = smaa_st_steering_vector(sintheta(nn), N, wd(mm), M);
%         Pb_linear(mm, nn) = a_linear' * Rc_linear * a_linear;
%         Pb_smaa(mm, nn)   = a_smaa'   * Rc_smaa   * a_smaa;
%     end
% end
% 
% % Display the clutter spectrum
% figure
% imagesc(sintheta, wd, 10*log10(abs(Pb_linear)))
% set(gca,'ydir','normal'), xlabel('angle'), ylabel('doppler')
% figure
% surf(sintheta, wd, 10*log10(abs(Pb_linear)))
% shading interp, xlabel('angle'), ylabel('doppler')
% figure
% imagesc(sintheta, wd, 10*log10(abs(Pb_smaa)))
% set(gca,'ydir','normal'), xlabel('angle'), ylabel('doppler')
% figure
% surf(sintheta, wd, 10*log10(abs(Pb_smaa)))
% shading interp, xlabel('angle'), ylabel('doppler')


% Add a jammer to the clutter matrix
% sigma2_i  = sigma2_t;
% sintheta  = 0.4;
% wd        = 0;
% ai_linear =      st_steering_vector(sintheta, N, wd, M);
% ai_smaa   = smaa_st_steering_vector(sintheta, N, wd, M);
% Ri_linear = sigma2_i * ai_linear * ai_linear';
% Ri_smaa   = sigma2_i * ai_smaa   * ai_smaa';
% Rc_linear = Rc_linear + Ri_linear;
% Rc_smaa   = Rc_smaa   + Ri_smaa;


% Add a target to the clutter matrix
% sintheta_t  = -0.3;
% wd_t        = 0;
at_linear =      st_steering_vector(sintheta_t, N, wd_t, M);
at_smaa   = smaa_st_steering_vector(sintheta_t, N, wd_t, M);
R_linear  = sigma2_t * at_linear * at_linear' + Rc_linear;
R_smaa    = sigma2_t * at_smaa   * at_smaa'   + Rc_smaa;


% Spectrum from the beamformer output with clutter, target, & jammer
sintheta = linspace(-1, 1);
wd = beta * sintheta;
for nn = 1: length(sintheta),
    for mm = 1: length(wd),
        a_linear =      st_steering_vector(sintheta(nn), N, wd(mm), M);
        a_smaa   = smaa_st_steering_vector(sintheta(nn), N, wd(mm), M);
        Pb_linear(mm, nn) = a_linear' * R_linear * a_linear;
        Pb_smaa(mm, nn)   = a_smaa'   * R_smaa   * a_smaa;
    end
end

% figure
% imagesc(sintheta, wd, 10*log10(abs(Pb_linear)))
% set(gca,'ydir','normal'), xlabel('angle'), ylabel('doppler')
% figure
% imagesc(sintheta, wd, 10*log10(abs(Pb_smaa  )))
% set(gca,'ydir','normal'), xlabel('angle'), ylabel('doppler')
% figure
% surf(sintheta, wd, 10*log10(abs(Pb_linear)))
% shading interp, xlabel('angle'), ylabel('doppler')
% figure
% surf(sintheta, wd, 10*log10(abs(Pb_smaa  )))
% shading interp, xlabel('angle'), ylabel('doppler')


% Diagonalize the clutter matrix
dval = 10;
Rc_linear = Rc_linear + dval * eye(size(Rc_linear));
Rc_smaa   = Rc_smaa   + dval * eye(size(Rc_smaa  ));

% Calculate optimal weights
wopt_linear = inv(Rc_linear) * at_linear;
wopt_smaa   = inv(Rc_smaa  ) * at_smaa  ;

% Filter the clutter and jammer
sintheta = linspace(-1, 1);
wd = beta * sintheta;
for nn = 1: length(sintheta),
    for mm = 1: length(wd),
        a_linear =      st_steering_vector(sintheta(nn), N, wd(mm), M);
        a_smaa   = smaa_st_steering_vector(sintheta(nn), N, wd(mm), M);
        Pb_linear(mm, nn) = abs(wopt_linear' * a_linear)^2;
        Pb_smaa(mm, nn)   = abs(wopt_smaa'   * a_smaa  )^2;
    end
end

% Display the filtered spectrum
% figure
% imagesc(sintheta, wd, 10*log10(abs(Pb_linear)))
% set(gca,'ydir','normal'), xlabel('angle'), ylabel('doppler')
% figure
% imagesc(sintheta, wd, 10*log10(abs(Pb_smaa  )))
% set(gca,'ydir','normal'), xlabel('angle'), ylabel('doppler')
% figure
% surf(sintheta, wd, 10*log10(abs(Pb_linear)))
% shading interp, xlabel('angle'), ylabel('doppler')
% figure
% surf(sintheta, wd, 10*log10(abs(Pb_smaa  )))
% shading interp, xlabel('angle'), ylabel('doppler')
