function [an] = airyzo1(nt)
%   This program is a modified version of a function obtained from 
%   free internet source www.mathworks.com/matlabcentral/fileexchange/
%   modified by B. Mahafza (bmahafza@dbresearch.net) in 2005
%       =========================================================
%   Purpose: This program computes the first nt zeros of Airy
%   functions Ai(x)
%   Input :  nt    --- Total number of zeros
%   Output:  an ---    first nt rooots for Ai(x)
format long
an = zeros(1,nt);
xb = zeros(1,nt);
ii = linspace(1,nt,nt);
u = 3.0.*pi.*(4.0.*ii-1)./8.0;
u1 = 1./(u.*u);
rt0 = -(u.*u).^(1.0./3.0).*((((-15.5902.*u1+.929844).*u1-.138889).*u1+.10416667).*u1+1.0);
rt = 1.0e100;
while(abs((rt-rt0)./rt)> 1.e-12);
x = rt0;
ai = airy(0,x);
ad = airy(1,x);
rt=rt0-ai./ad; 
if(abs((rt-rt0)./rt)> 1.e-12);
rt0 = rt;
end;
end;
an(ii)= rt;
end
