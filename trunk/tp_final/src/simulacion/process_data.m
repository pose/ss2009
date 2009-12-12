function data = process_data(data, aux_data, i)

	for j = 1:columns(aux_data{i})
		data{i}(j) = (data{i-1}(j) * (i-1) + aux_data{i}(j) ) / i;
	end
end
