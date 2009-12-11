%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo: normal.m
% Retorna valores aleatorios normalmente distribuidos, de media m y varianza v

function ret = normal(m, v)
	u = rand();
	ret = (u^0.135 - (1 - u)^0.135) / 0.1975;
	ret = ret * sqrt(v) + m;
	if (ret < 0)
		ret = normal(m, v);
	end
end
