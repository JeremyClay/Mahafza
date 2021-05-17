function a = smaa_st_steering_vector(sintheta, N, wd, M)

a_N = exp(-j*pi*sintheta*[-(N-1):+(N-1)]');
b_M = exp(-j*pi*wd      *[0:M-1]');

a_N = a_N .* ts_weighting(N);

a = kron(b_M, a_N);

