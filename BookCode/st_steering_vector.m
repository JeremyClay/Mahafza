function a = st_steering_vector(sintheta, N, wd, M)

a_N = exp(-j*pi*sintheta*[0:N-1]');
b_M = exp(-j*pi*wd      *[0:M-1]');

a = kron(b_M, a_N);

