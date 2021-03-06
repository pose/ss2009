%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo manySimulations.m
% Computa el punto d).

format long;
rand('seed', 1000);

%50 Hs
max_time = 3000;

[means(1) vv ww xx yy zz] = simulate(0.6, max_time);
for i = 2 : 10
	[just_mean(i) xx yy] = simulate(0.6, max_time);
	means(i) = (means(i-1) * (i-1) + just_mean(i) ) / i;
end

fprintf(stdout, 'Estimacion del parametro: %g\n', means(i));
alpha = .05;
inv = norminv(1-alpha/2);
semi = inv*sqrt(var(just_mean(1:i))/(i));
fprintf(stdout, 'Semiamplitud del intervalo de confianza para alpha = %g: %g\n',
		alpha, semi);

just_mean(1) = means(1);

for i=1:10
	fprintf(stdout, 'Tiempo medio del cliente en el sistema %d: %g\n',
		i, just_mean(i));	
end
