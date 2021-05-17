function Xout = LMS(Xin, D, B, mu, sigma, alpha)
%   X = data vector ; size = 1 x N
%	D = desired signal vector; size = 1 x N
%	N = number of data samples adn of adaptive iterations
%	B = adaptive coefficients of Lht order fFIRfilter; size = 1 x L
%	L = order of adaptive system
%	mu = convergence parameter
%	sigma = input signal power estimate
%	alpha = exponential forgetting factor
N = size(Xin,2)
L = size(B,2)-1
px = B;
for k = 1:N    
    px(1) = Xin(k);
    Xout(k) = sum(B.*px);	
    E = D(k) - Xout(k);
    sigma = alpha*(px(1)^2) + (1 - alpha)*sigma;
    tmp = 2*mu/((L+1)*sigma);
    B = B + tmp*E*px;
    px(L+1:-1:2) = px(L:-1:1);
end
return