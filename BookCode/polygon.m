% this routine calculates the scattered electric field of an arbitrary
% N-sided polygon located in the x-y plane.
clc
clear all
close all
frequency = 1.0e9;                  % desired radar frequency
freqGH = num2str(frequency*1.e-9);
c = 299795645.0;                    % speed of light
w = 2.0*pi*frequency;               % radian frequency
wavenumber = w/c;                   % free space wavenumber
mu = 4.0*pi*1.0e-7;                 % free space permeability
z_o = 376.7343;                     % free space wave impedance

nsides = 3;                         % number of polygon sides
vertices(1,:) = [0.0 0.0 0.0];      % vertexes of polygon (counterclockwise)
vertices(2,:) = [1.0 0.5 0.0];      % vertexes of polygon (counterclockwise)
vertices(3,:) = [1.5 0.0 0.0];      % vertexes of polygon (counterclockwise)

for n = 1:nsides
    if n == nsides
        alpha_n(nsides,1) = vertices(1,1) - vertices(nsides,1);
        alpha_n(nsides,2) = vertices(1,2) - vertices(nsides,2);
        alpha_n(nsides,3) = vertices(1,3) - vertices(nsides,3);
    else 
        alpha_n(n,1) = vertices(n+1,1) - vertices(n,1);
        alpha_n(n,2) = vertices(n+1,2) - vertices(n,2);
        alpha_n(n,3) = vertices(n+1,3) - vertices(n,3);
    end
    alpha_n(n, 1:3) = alpha_n(n, 1:3)/norm(alpha_n(n, 1:3));
end
 
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
        
        w_vect(1) = 2*wavenumber*sin(theta(i_theta))*cos(phi(i_phi));
        w_vect(2) = 2*wavenumber*sin(theta(i_theta))*sin(phi(i_phi));
        w_vect(3) = 0.0;
            
        s_term = 0.0;
        
        for n = 1:nsides
            expterm = exp(i*dot(w_vect, vertices(n,1:3)));
            if n == 1
                num = dot(cross(normal_vect, alpha_n(n,1:3)), alpha_n(nsides,1:3));
                denom = dot(w_vect, alpha_n(n,1:3))*dot(w_vect, alpha_n(nsides,1:3));
            else
                num = dot(cross(normal_vect, alpha_n(n,1:3)), alpha_n(n-1,1:3));
                denom = dot(w_vect, alpha_n(n,1:3))*dot(w_vect, alpha_n(n-1,1:3));
            end
            s_term = s_term + num*expterm/denom;
        end
        
        vect_term = dot(theta_vect, cross(phi_vect, normal_vect));
        
        es(i_theta, i_phi) = -j*w*mu/2.0/pi/z_o*vect_term*s_term;
       
    end
end

rcs = 20.0*log10(sqrt(4*pi)*abs(es));
plot(180*theta/pi, rcs)
axis([-90 90 -120 20])
xlabel('\bfAspect angle - degrees')
ylabel('\bfRCS (dBsm')
grid on
title  (['Frequency = ',[freqGH],'  GHz']);

