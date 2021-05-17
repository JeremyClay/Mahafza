clear all

mu_o = pi*4.0e-7;                 % free space permeability
epsilon_o = 8.854e-12;            % free space permittivity

c = 1.0/sqrt(mu_o * epsilon_o);   % speed of light

length_x = 2.0;                   % x-width of region
nx = 200;                         % number of x grid points 
dx = length_x / (nx - 1);         % x grid size

x = linspace(0.0, length_x, nx);  % x array

length_y = 2.0;                   % y-width of region 
ny = 200;                         % number of y grid points
dy = length_y / (ny - 1);         % y grid size

y = linspace(0.0, length_y, ny);  % y array

max_timestep = c*sqrt(1.0/(dx*dx) + 1.0/(dy*dy));	% max tstep for FDTD
max_timestep = 1.0/max_timestep;

delta_t = 0.5*max_timestep;      % delta t a little less than max tstep

er = 8.0;                         % relative permittivity of slab

epsilon = epsilon_o*ones(ny, nx); % epsilon array
mu = mu_o*ones(ny - 1, nx - 1);   % mu array

a1 = [0.5 1.5 1.5 0.5 0.5];       % for drawing slab on plot 
a2 = [0.6 0.6 0.8 0.8 0.6];       % for drawing slab on plot

x1 = fix(0.5/dx)+1;               % grid extents for slab
y1 = fix(0.6/dy);                 % grid extents for slab
x2 = fix(1.5/dx)+1;               % grid extents for slab
y2 = fix(0.8/dy);                 % grid extents for slab

epsilon(y1:y2,x1:x2) = er*epsilon_o;  % set epsilon inside slab

j_x = nx/2;                       % x location of current source
j_y = ny/2;                       % y location of current source

e_z_1 = zeros(ny, nx);          % initialize array. e_z at boundaries will remain 0
h_x_1 = zeros(ny - 1, nx - 1);	% initialize array
h_y_1 = zeros(ny - 1, nx - 1);	% initialize array
e_z_2 = zeros(ny, nx);			% initialize array. e_z at boundaries will remain 0
h_x_2 = zeros(ny - 1, nx - 1);	% initialize array
h_y_2 = zeros(ny - 1, nx - 1);	% initialize array

ntim = 300;                     % number of desired time points
f_o = 600e6;                    % base frequency for pulse
tau = 1.0/(4.0*pi*f_o);         % tau for pulse

for i_t = 1:ntim
   
   time(i_t) = i_t * delta_t;
   
   i_t
   time(i_t)
   
   if time(i_t) > 3.36e-9
       break
   end
   
   jz(i_t) = (4.0 * (time(i_t)/tau)^3 - (time(i_t)/tau)^4) * exp(-time(i_t)/tau);
   
   for i_x = 2:nx-1		% ez at boundaries remains zero
      for i_y = 2:ny-1	% ez at boundaries remains zero
         
         j = 0.0;
         if i_x == j_x
            if i_y == j_y
               j = jz(i_t);
            end
         end
         
         if rem(i_t, 2) == 1
            a = 1.0/dx*(h_y_1(i_y, i_x) - h_y_1(i_y, i_x - 1));
            b = 1.0/dy*(h_x_1(i_y, i_x) - h_x_1(i_y - 1, i_x));
            e_z_2(i_y, i_x) = e_z_1(i_y, i_x) + (delta_t/epsilon(i_y, i_x))*(a - b) - j;
         else
            a = 1.0/dx*(h_y_2(i_y, i_x) - h_y_2(i_y, i_x - 1));
            b = 1.0/dy*(h_x_2(i_y, i_x) - h_x_2(i_y - 1, i_x));
            e_z_1(i_y, i_x) = e_z_2(i_y, i_x) + (delta_t/epsilon(i_y, i_x))*(a - b) - j;
         end
         
      end
   end
   
   for i_x = 1:nx-1
      for i_y = 1:ny-1
         
         if rem(i_t, 2) == 1
            h_x_2(i_y, i_x) = h_x_1(i_y, i_x) - (delta_t/mu(i_y, i_x)/dy)*(e_z_2(i_y + 1, i_x) - e_z_2(i_y, i_x));
            h_y_2(i_y, i_x) = h_y_1(i_y, i_x) + (delta_t/mu(i_y, i_x)/dx)*(e_z_2(i_y, i_x + 1) - e_z_2(i_y, i_x));
         else
            h_x_1(i_y, i_x) = h_x_2(i_y, i_x) - (delta_t/mu(i_y, i_x)/dy)*(e_z_1(i_y + 1, i_x) - e_z_1(i_y, i_x));
            h_y_1(i_y, i_x) = h_y_2(i_y, i_x) + (delta_t/mu(i_y, i_x)/dx)*(e_z_1(i_y, i_x + 1) - e_z_1(i_y, i_x));
         end
      end
   end
   
   pcolor(x, y, abs(e_z_2))
   line(a1, a2, 'Linewidth', 1.0, 'Color', 'white');
   xlabel('X (m)')
   ylabel('Y (m)')
   title('Ez (V/m)')
   axis square
   shading interp
   %colormap gray
   caxis([0 .1])
   %axis([0 2 0 2 0 .1])
   fr(i_t) = getframe;
end