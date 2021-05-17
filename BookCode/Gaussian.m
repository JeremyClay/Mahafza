function x = Gaussian(taup, sigma)
eps = 0.000001;
i = 0;
sigma = 1;
del = 2*taup/200;
for tau = -1.*taup:del:taup
   i = i + 1;
   j = 0;
   fd = linspace(-5/taup,5/taup,201);
   val1 = exp(-tau^2/4*sigma);
   val2 = exp(-pi*pi.*fd.*fd*sigma*sigma); 
   val3 = exp( sqrt(-1) * pi*fd*tau);
   x(:,i) = abs( val1) .* abs(val2) .* abs(val3);
end
end

