% Use this program to reproduce Fig. 5.9a of text
clc
close all
clear all
pri=1;
taup = .2;
n=6;
gap = 0;
eps = 0.000001;
b = 1. / taup;
ii = 0.;
for q = 0
   tauo = q *pri ;
   index = -1.;
   for tau1 = tauo-taup:0.0533:tauo+taup
      index = index + 1;
      tau = -taup + index*.0533;
      ii = ii + 1;
      j = 0.;
      for fd = -b:.033:b
         j = j + 1;
                     val1 = 1. -abs(tau) / taup;
            val2 = pi * taup * fd * (1.0 - abs(tau) / taup);
            val3 = abs(val1 * sin(val2+eps) /(val2+eps)); 
            val4 = abs((sin(pi*fd*pri*n+eps))/(sin(pi*fd*pri+eps)));
            x(j,ii)=  val3 * val4 / n;
         
      end
   end
end






figure(1)
time = linspace(-taup,taup,size(x,2));
doppler = linspace(-1/taup,1/taup,size(x,1));
mesh(time, doppler,x)
xlabel ('Delay - seconds')
ylabel ('Doppler - Hz')
zlabel ('Ambiguity function')
axis tight
figure(2)
contour(time, doppler,(x));
xlabel ('Delay - seconds')
ylabel ('Doppler - Hz')
grid
axis tight