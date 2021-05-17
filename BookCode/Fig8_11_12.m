% this program generates Figs. 8.11 and 8.12 of text
close all
clear all
psi = 0.01:0.05:90;
[rh,rv] = ref_coef (psi, 65,30.7);
gamamodv = abs(rv);
gamamodh = abs(rh);
figure
plot(psi,gamamodv,'k',psi,gamamodh,'k -.','linewidth',1.5);
grid
legend ('Vertical Polarization','Horizontal Polarization')
xlabel('\bfGrazing angle - degrees');
ylabel('\bfReflection coefficient - magnitude')
pv = -angle(rv);
ph = angle(rh);
figure 
plot(psi,pv,'k',psi,ph,'k -.','linewidth',1.5);
grid
legend ('\bfVertical Polarizatio','Horizontal Polarization')
xlabel('\bfGrazing angle - degrees');
ylabel('\bfReflection coefficient- phase')
