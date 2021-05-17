function y = sinc(x)

if abs(x) < 0.001
    y = 1.0;
else
    y = sin(x)/x;
end