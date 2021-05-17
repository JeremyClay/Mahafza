function s = la_sampled_wave(N, dol, sinbeta)

k = 2*pi * dol * sinbeta;

% brute force method
for m = 1: N,
    s(m) = exp(j*(m-1)*k);
end

% Return a column vector, not a row vector
if size(s,1)==1,
    s = s.';
end
