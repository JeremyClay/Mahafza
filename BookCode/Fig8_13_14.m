% this program generates Fig. 8.13 and 8.14 of text
close all
clear all
psi = 0.01:0.25:90;
epsp = [2.8];
epspp = [0.032];% 0.87 2.5 4.1];
[rh1,rv1] = ref_coef(psi, epsp,epspp);
gamamodv1 = abs(rv1);
gamamodh1 = abs(rh1);
epsp = [5.8] ;
epspp = [0.87];
[rh2,rv2] = ref_coef(psi, epsp,epspp);
gamamodv2 = abs(rv2);
gamamodh2 = abs(rh2);
epsp = [10.3];
epspp = [2.5];
[rh3,rv3] = ref_coef(psi, epsp,epspp);
gamamodv3 = abs(rv3);
gamamodh3 = abs(rh3);
epsp = [15.3];
epspp = [4.1];
[rh4,rv4] = ref_coef(psi, epsp,epspp);
gamamodv4 = abs(rv4);
gamamodh4 = abs(rh4);
figure(1)
semilogx(psi,gamamodh1,'k',psi,gamamodh2,'k-.',psi,gamamodh3,'k.',psi,gamamodh4,'k:','linewidth',1);
grid
xlabel('\bfGrazing angle - degrees');
ylabel('\bfReflection coefficient - amplitude')
legend('moisture = 0.3%','moisture = 10%%','moisture = 20%','moisture = 30%')
title('\bfhorizontal polarization')
figure(2)
semilogx(psi,gamamodv1,'k',psi,gamamodv2,'k-.',psi,gamamodv3,'k.',psi,gamamodv4,'k:','linewidth',1);
grid
xlabel('\bfGrazing angle - degrees');
ylabel('\bfReflection coefficient - amplitude')
legend('moisture = 0.3%','moisture = 10%%','moisture = 20%','moisture = 30%')
title('\bfveritcal polarization')