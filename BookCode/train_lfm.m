function x = train_lfm (taup, n, pri,b);
if( taup >= pri / 2.)
   'ERROR. Pulse width must be less than the PRI/2.'
   return
end
gap = pri - taup;
eps = 0.000001;
ii =0;
for q = -(n-1):1:n-1
   tauo = q *pri ;
   for tau1 = tauo-taup:0.0533:tauo+gap
      tau = tau1 - q *pri;
      ii = ii + 1;
      j = 0.;
      for fd = -1/taup:.033:1/taup
         j = j + 1;
         if (abs(tau) <= taup)
            val1 = 1. - (abs(tau)) / taup;
            val2 = pi * taup * (fd +b*tau/taup) * (1.0 - (abs(tau)) / taup);
            val3 = abs(val1 * sin(val2+eps) /(val2+eps)); 
            val4 = abs((sin(pi*fd*(n-abs(q))*pri+eps))/(sin(pi*fd*pri+eps)));
            x(j,ii)=  val3 * val4 / n;
         else
            x(j,ii) = 0.;
         end
    
      end
 
   end
end
return




