%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo: semi_amplitude.m
% Funcion que realiza el computo del intervalo de confianza.

%Retorna
%	semiInterval semi longitud del intervalo de confianza

function semiInterval = semi_amplitude(data,alpha)

	for i = 1:length(data)-1
		data{i} = data{i+1};
	end

	array_length = columns(data{1});

	for i = 1:length(data)
		for j = 1:array_length
			new_data{j}(i) = data{i}(j);
		end
	end

	for i = 1:length(new_data)
		length = columns(new_data{i});	
		inv = norminv(1-alpha/2);
		semiInterval(i) = inv*sqrt(var(new_data{i}(1:length))/(length));
	end
end
