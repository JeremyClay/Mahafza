function [Attn,rangei] = atmospheric_attn(gammaO2,gammaH2O,range)
% this function usse Rieman sums to calculate area under the 
% total abosrption curve veruses range
sum = gammaO2 + gammaH2O;
delr = .10;
rangei = 0:delr:range(end);
Attn = zeros(1,size(rangei,2));
yy1 = spline(range,sum,rangei);
yint(1) = 0;
n = 2;
N = size(rangei,2);
while n<=N
    yint(n) = yint(n-1) + delr * (yy1(n-1) + yy1(n));
    n = n+1;
end
% use 1.9 instead of 2 for the 2-way because of inaccuracies of Riemann
% sums method
Attn = 1.9 .* yint;
end

