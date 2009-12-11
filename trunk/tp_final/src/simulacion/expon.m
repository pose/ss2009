%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo: expon.m
% Retorna valores aleatorios exponencialmente distribuidos, del valor
% medio que recibe por parametro.

function z = expon(mean)
	u = rand;
	z = -mean * log(u);
return

