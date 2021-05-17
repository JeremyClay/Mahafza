% Display Marhefza's subroutine rect_array.m
% 
%%%%%%%%%%%%%%%%%%%% ************************ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function computes the 3-D directive gain patterns for a planar array
% This function uses the fft2 to compute its output
%%%%%%%%%%%%%%%%%%%% ************  INPUTS ************ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nxr ==> number of along x-aixs; 
% Nyr ==> number of elemnts along y-axis
% dolxr ==> elemnet spacing in x-direction in lambda units
% dolyr ==> element spacing in y-direction in lambda units
% theta0 ==> elevation steering angle in degrees,
% phi0 ==> azimuth steering angle in degrees
% winid ==> window identifier; 
% winid negative ==> no window ; winid positive ==> use window given by win
% win ==> input window function (2-D window) MUST be of size (NXr X Nyr)
% nbits is the number of nits used in phase quantization; nbits negative ==> NO quantization
%%%%%%%%%%%%%%%%%%%% *********** OUTPUTS ************* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pattern ==> directive gain pattern
%%%%%%%%%%%%%%%%%%%% ************************ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% If x_max > 51, then ans is 2048x2048 array, get Out of memory message and Fig 1 will not close.

% close windows
close all
% clear memory
clear all
% clear command window
clc

% initialize all variables except large array
starttime = clock;
cumtime=0;
x_min =50;
x_max =52;
X = zeros(x_max,1);
Y = zeros(x_max,1);
Z = zeros(x_max,1);

dolxr = 0.8;
dolyr = 0.8;
theta0 = 30;
phi0 = 30;
winid = 1;
nbits = -1;

% Size figures created by rect_array.m
% MATLAB defines the figure Position property as a vector. [left bottom width height]
% The figure Position property does not include the window borders, so this example uses a width of 5 pixels on the sides and bottom and 30 pixels on the top. 
    bdwidth = 5;
    topbdwidth = 30;
% Ensure root units are pixels and get the size of the screen 
    set(0,'Units','pixels') 
    scnsize = get(0,'ScreenSize');
    wide = scnsize(3)/3;
    tall = scnsize(4)/3;
% Define the size and location of the figures 
    pos1  = [bdwidth,... 
    2*tall,...
    wide-2*bdwidth,...
    tall-75];
    pos2 = [pos1(1),...
    tall,...
    pos1(3),...
    pos1(4)];
    pos3 = [pos2(1),...
    0,...
    pos2(3),...
    pos2(4)];
% Create the figures
    figure('Position',pos1) 
    figure('Position',pos2)

disp('#   Time');    

% loop through array sizes from one by one to x_max by x_max
for k = x_min:x_max;
    Nxr = k;
    Nyr = k;
    if winid > 0
      win = ones(Nxr,Nyr);
    else
        win = ones(1,1);
    end
    tic;
    rect_array(Nxr,Nyr,dolxr,dolyr,theta0,phi0,winid,win,nbits);
    t = toc;
    X(k) = k;
    Y(k) = t;
    a = [1 0];
    Z(k) = dot(a,size(ans));
    cumtime=cumtime+t;
    Str = [k t];
    [s,errmsg] = sprintf('%g   %g',Str);
    disp(s);
end

% this figure displays execution time and array size for each array
% prototype code came from MatLab on-line help

figure('Position',pos3);

%Using low-level line and axes routines allows you to superimpose objects easily. 
% Plot the first data, making the color of the line and the corresponding 
% x- and y-axis the same to more easily associate them. 
    hl1 = line(X,Y,'Color','r');
    ax1 = gca;
    set(ax1,'XColor','r','YColor','r');
    xlabel('size of phased array');
    ylabel('execution time');

%Next, create another axes at the same location as the first, placing the x-axis 
% on top and the y-axis on the right. Set the axes Color to none to allow the first 
% axes to be visible and color code the x- and y-axis to match the data. 
    ax2 = axes('Position',get(ax1,'Position'),...
           'XAxisLocation','bottom',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor','k','YColor','k',...
           'Xgrid','on','Ygrid','on');
%Draw the second set of data in the same color as the x- and y-axis. 
    hl2 = line(X,Z,'Color','k','Parent',ax2);
    ylabel('size of ans');

% Creating Coincident GridsSince the two axes are completely independent, 
% MATLAB determines tick mark locations according to the data plotted in each. 
% It is unlikely the gridlines will coincide. This produces a somewhat confusing 
% looking graph, even though the two grids are drawn in different colors. 
% However, if you manually specify tick mark locations, you can make the grids coincide. 
% The key is to specify the same number of tick marks along corresponding axis lines 
% (it is also necessary for both axes to be the same size). 
% The following graph of the same data uses six tick marks per axis, equally spaced 
% within the original limits. To calculate the tick mark location, obtain the limits 
% of each axis and calculate an increment. 

    xlim(ax1, [0 x_max])
    y_max = 5*ceil(max(Y)/5);
    ylim(ax1, [0 y_max])
    xlim(ax2, [0 x_max])
    ylim(ax2, [0 1000])

    xlimits = get(ax1,'XLim');
    ylimits = get(ax1,'YLim');
    xinc = (xlimits(2)-xlimits(1))/5;
    yinc = (ylimits(2)-ylimits(1))/5;

    Str = [cumtime];
    [s,errmsg] = sprintf('sum   %g',Str);
    disp(s);
    disp('elapsed time');
    Str = [etime(clock,starttime)];
    [s,errmsg] = sprintf('sum   %g',Str);
    disp(s);

% check remaining memory
    %dumpmemmex;
% for my system, for x_max = 52, I receive an out of memory message when
% the system attempts to render Figure No. 1 although
% dumpmemmex reports the largest available
% memory block is 98779136 bytes (94.2 MB).  
% However taskmanager shows approximately 697 MB available

    
% Now set the tick mark locations. 
%    set(ax1,'XTick',[xlimits(1):xinc:xlimits(2)],...
%        'YTick',[ylimits(1):yinc:ylimits(2)])
%    set(ax2,'XTick',[xlimits(1):xinc:xlimits(2)],...
%        'YTick',[ylimits(1):yinc:ylimits(2)])
    
