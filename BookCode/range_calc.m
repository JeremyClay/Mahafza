function [output_par] = range_calc (pt, tau, fr, time_ti, gt, gr, freq, ...
   sigma, te, nf, loss, snro, pcw, range, radar_type, out_option)
c = 3.0e+8;
lambda = c / freq;
if (radar_type == 0)
   pav = pcw;
else
   % Compute the duty cycle
   dt = tau * 0.001 * fr;
   pav = pt * dt;
end
pav_db = 10.0 * log10(pav);
   lambda_sqdb = 10.0 * log10(lambda^2);
   sigmadb = 10.0 * log10(sigma);
   for_pi_cub = 10.0 * log10((4.0 * pi)^3);
   k_db = 10.0 * log10(1.38e-23);
   te_db = 10.0 * log10(te);
   ti_db = 10.0 * log10(time_ti);
   range_db = 10.0 * log10(range * 1000.0);
if (out_option == 0)
   %compute SNR
      % Implement Eq. (3.63)
   snr_out = pav_db + gt + gr + lambda_sqdb + sigmadb + ti_db - ...
      for_pi_cub - k_db - te_db - nf - loss - 4.0 * range_db
   index = 0;
   for range_var = 10:10:1000
      index = index + 1;
      rangevar_db = 10.0 * log10(range_var * 1000.0);
      snr(index) = pav_db + gt + gr + lambda_sqdb + sigmadb + ti_db - ...
         for_pi_cub - k_db - te_db - nf - loss - 4.0 * rangevar_db;
   end
   var = 10:10:1000;
   plot(var,snr,'k')
   xlabel ('Range - Km');
   ylabel ('SNR - dB');
   grid
else
  range4 = pav_db + gt + gr + lambda_sqdb + sigmadb + ti_db - ...
     for_pi_cub - k_db - te_db - nf - loss - snro;
  range = 10.0^(range4/40.) / 1000.0
   index = 0;
  for snr_var = -20:1:60
     index = index + 1;
     rangedb = pav_db + gt + gr + lambda_sqdb + sigmadb + ti_db - ...
        for_pi_cub - k_db - te_db - nf - loss - snr_var;
     range(index) = 10.0^(rangedb/40.) / 1000.0;
  end
  var = -20:1:60;
  plot(var,range,'k')
  xlabel ('Minimum SNR required for detection - dB');
  ylabel ('Maximum detection range - Km');
  grid
end
return
   











