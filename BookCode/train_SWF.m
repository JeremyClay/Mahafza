function x = train_SWF (taup, n, pri,Bi, b, delf);
if( taup >= pri / 2.)
   'ERROR. Pulse width must be less than the PRI/2.'
   return
end
gap = pri - taup;
eps = 0.000001;
ii =0;
for q = -(n-1):1:n-1
   tauo = q *pri ;
   index = -1.;
   for tau1 = tauo-taup:0.0533:tauo+gap
      index = index + 1;
      tau = -taup + index*.0533;
      ii = ii + 1;
      j = 0.;
      for fd = -1/taup:.033:1/taup
          fd1 = fd + ((b+Bi) * tau1 /taup);
         j = j + 1;
         if (abs(tau) <= taup)
            val1 = 1. - abs(tau1) / taup;
            val2 = pi * taup * (1.0 - abs(tau1) / taup);
            val = val2 * fd1;
            x1 = abs( val1 .* (sin(val+eps)./(val+eps))).^2;
            val4 = abs(sin(pi*pri*((fd+delf*tau/pri)*(n-abs(q))+eps))/...
                (sin(pi*pri*(fd+delf*tau/pri)+eps)));
            x(j,ii)=  x1 * val4 / n;
         else
            x(j,ii) = 0.;
         end
    
      end
 
   end
end
return

