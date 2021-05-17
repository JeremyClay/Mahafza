clear all
close all

sintheta_t1 = .4;
wd_t1 =-.6;

sintheta_t2 = -.6;
wd_t2 = .2;

[LL, sintheta, wd] = stap_std(sintheta_t1, wd_t1, sintheta_t2, wd_t2);
LL = LL / max(max(abs(LL)));
LL = max(LL, 1e-6);

figure (3)
imagesc(sintheta, wd, 10*log10(abs(LL)))
colorbar
title('STAP Detection of target & jammer; clutter removed');
set(gca,'ydir','normal'), xlabel('sine angle'), ylabel('normalized doppler')

figure (4)
surf(sintheta, wd, 10*log10(abs(LL)))
shading interp
title('STAP Detection of target & jammer; clutter removed');
set(gca,'ydir','normal'), xlabel('sine angle'), ylabel('normalized doppler')


%stop


[LL, sintheta, wd] = stap_smaa(sintheta_t1, wd_t1, sintheta_t2, wd_t2);
LL = LL / max(max(abs(LL)));
LL = max(LL, 1e-6);

figure
imagesc(sintheta, wd, 10*log10(abs(LL)))
colorbar
set(gca,'ydir','normal'), xlabel('sine angle'), ylabel('normalized doppler')
title('STAP Detection of target; jammer & clutter removed');

figure
surf(sintheta, wd, 10*log10(abs(LL)))
shading interp
set(gca,'ydir','normal'), xlabel('sine angle'), ylabel('normalized doppler')
title('SNR after SMAA STAP Detection of target, clutter, noise & jammer');
