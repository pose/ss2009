%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo: shiftl.m
% Dado un vector de n elementos, los shiftea a izquierda

function vec = shiftl(vec)
	switch length(vec)
	case 0
		vec = [];
	case 1
		vec = [];
	otherwise
		vec = vec(2:length(vec));
	end 
end
