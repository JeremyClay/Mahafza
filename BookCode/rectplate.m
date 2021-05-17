close all
clear all

frequency = 2.6e9;                  % desired radar frequency
freqGH = num2str(frequency*1.e-9);

c = 299795645.0;                    % speed of light
w = 2.0*pi*frequency;               % radian frequency
wavenumber = w/c;                   % free space wavenumber
mu = 4.0*pi*1.0e-7;                 % free space permeability
z_o = 376.7343;                     % free space wave impedance

l_x = 1.0;                          % length of plate
l_y = 1.0;                          % width of plate

normal_vect = [0 0 1];              % +z normal for x-y plane

theta_points = 180;                 % number of points in theta
phi_points = 1;                     % number of points in phi

theta = linspace(-0.5*pi, 0.5*pi, theta_points);
phi = linspace(0.0, 2.0*pi, phi_points);

for i_theta = 1:theta_points
      
    for i_phi = 1:phi_points
        
        theta_vect(1) = cos(theta(i_theta))*cos(phi(i_phi));
        theta_vect(2) = cos(theta(i_theta))*sin(phi(i_phi));
        theta_vect(3) = -sin(theta(i_theta));
        
        phi_vect(1) = -sin(phi(i_phi));
        phi_vect(2) = cos(phi(i_phi));
        phi_vect(3) = 0.0;
        
        u = sin(theta(i_theta))*cos(phi(i_phi));
        v = sin(theta(i_theta))*sin(phi(i_phi));
        
        vect_term = dot(theta_vect, cross(phi_vect, normal_vect));
        
        es(i_theta, i_phi) = -j*w*mu/2.0/pi/z_o*vect_term*l_x*l_y*sinc(wavenumber*u*l_x)*sinc(wavenumber*v*l_y);
       
    end
end

rcs = 20.0*log10(sqrt(4*pi)*abs(es));
plot(180*theta/pi, rcs)
axis([-90 90 -60 30])
xlabel('\bfTheta (degrees)')
ylabel('\bfRCS (dBsm')
grid on
title  (['Frequency = ',[freqGH],'  GHz']);

return



