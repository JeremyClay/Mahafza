function [yk] = leastms(xk, dk, alpha, mu, bk, sigmma)
%this function implements the LMS algorithm defined in Eq. (11.66)
L = size(bk,2) % order of FIR filter
n = size(xk,2) % number of data points
nd = size(dk,2);
if (n~=nd | mu < 0 | mu >1 | alpha <0 | alpha >1)
    fprintf('Error xk and dk must be of equal size, check value of alpha or check value of mu')
else
end
pxk = zeros(1,n);
for k = 1, n
    pxk(1) = xk(k);
    xk(k) = 0;
    for ll = 1, L
        xk(k) = xk(k) + bk(ll) * pxk(ll);
    end
    error = dk(k) - xk(k);
    sigmma = alpha * pxk(1)^2  + (1-alpha) * sigmma;
    val = 2 * mu / (L+1) / sigmma;
    for ll = 1,L
        bk(ll) = bk(ll) + val * error * pxk(ll);
    end
    for ll = L:-1:2
        pxk(ll) = pxk(ll-1);
    end
end
yk = xk;
    