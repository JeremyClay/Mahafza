function fofx = que_func(x)
% This function computes the value of the Q-function
% listed in Eq.(12.16). It uses the approximation in Eq.s (12.39) and (12.40)
if (x >= 0) 
		denom = 0.661 * x + 0.339 * sqrt(x^2 + 5.51);
   expo = exp(-x^2 /2.0);
   fofx = 1.0 - (1.0 / sqrt(2.0 * pi)) * (1.0 / denom) * expo;
else
   denom = 0.661 * x + 0.339 * sqrt(x^2 + 5.51);
   expo = exp(-x^2 /2.0);
   value = 1.0 - (1.0 / sqrt(2.0 * pi)) * (1.0 / denom) * expo;
   fofx = 1.0 - value;
end