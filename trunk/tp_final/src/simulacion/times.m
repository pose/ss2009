%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo: times.m
% Dado el tipo de evento retorna el intervalo de tiempo en el que debe volver
% a ocurrir dicho evento, haciendo una realizacion de la variable aleatoria
% que lo modela.

%TODO salvo el caso 2 y 6 hay que cambiar todos los tiempos - El de los E es triangular
%y el de 1 parece exponencial
function ret = times(event_type)
	switch(event_type)
		case 1 % Tiempo entre arrbos a R
			ret = expon(8.2202);
		case 2 % Tiempo de servicio en R
			ret = unif(10, 20);
		case 3 % Tiempo de servicio en en E1
			ret = triangle(0,1.25,1.81);
		case 4 % Tiempo de servicio en E2
			ret = triangle(0,1.25,1.81);
		case 5 % Tiempo de servicio en E3
			ret = triangle(0,1.25,1.81);
		case 6 % Tiempo de servicio en ST
			ret = expon(40);
		otherwise
			error('Tipo de evento desconocido');
	end	
end
