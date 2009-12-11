%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo STStressTest.m
% Computa el punto e).

rand('seed', 1000);

%160 Hs
max_time = 9600;
[means(1) delays(1) ss(1) xx yy] = simulate(0.05, max_time);
for i = 2:20
	p = 0.05 * i;
	[just_mean(i) delays(i) ss(i) xx yy] = simulate(p, max_time);
	means(i) = (means(i-1) * (i-1) + just_mean(i) ) / i;
end

fprintf(stdout, 'Estimacion del parametro: %g\n', means(i));
alpha = .05;
inv = norminv(1-alpha/2);
semi = inv*sqrt(var(just_mean(1:i))/(i));
fprintf(stdout, 'Semiamplitud del intervalo de confianza para alpha = %g: %g\n',
		alpha, semi);