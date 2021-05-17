function c = ts_weighting(N)
%c = ts_weighting(N)
%
% returns the triangular weighting scheme defined in SSAMAR paper
% N - number of transmitting antenna elements

c = zeros(2*N-1,1);
c(1:N-1) = [1:N-1];
c(N) = N;
c(N+1:2*N-1) = 2*N-[N+1:2*N-1];
