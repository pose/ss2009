%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo: unif.m
% Retorna valores aleatorios uniformemente distribuidos, entre los valores que
% recibe por parametro.

function [ret] = unif(lower, upper)
	ret = lower + (rand() * (upper - lower));
end
