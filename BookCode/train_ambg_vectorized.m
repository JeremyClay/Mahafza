function x = train_ambg_vectorized(taup, n, pri)

if (taup >= pri/2)
	'ERROR. Pulse width must be less than the PRI/2.'
	return
end
	
eps = 1.0e-6;
bw = 1/taup;

q = -(n-1):1:n-1;
offset = 0:0.0533:pri;
[Q, S] = meshgrid(q, offset);
Q = reshape(Q, 1, length(q)*length(offset));
S = reshape(S, 1, length(q)*length(offset));

tau = (-taup * ones(1,length(S))) + S;
fd = -bw:0.033:bw;
[T, F] = meshgrid(tau, fd);

Q = repmat(Q, length(fd), 1);
S = repmat(S, length(fd), 1);
N = n * ones(size(T));

val1 = 1.0-(abs(T))/taup;
val2 = pi*taup*F.*val1;
val3 = abs(val1.*sin(val2+eps)./(val2+eps));
val4 = abs(sin(pi*F.*(N-abs(Q))*pri+eps)./sin(pi*F*pri+eps));
x = val3.*val4./N;

[rows, cols] = size(x);
x = reshape(x, 1, rows*cols);
T = reshape(T, 1, rows*cols);
indx = find(abs(T) > taup);
x(indx) = 0.0;
x = reshape(x, rows, cols);

return
				