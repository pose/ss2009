function ret = parte3()
	
	mm1;
	means=[getclientmean];

	error=1;
	%err=[1];

	mean_sum = sum(means);
	arr_size = 1;

	while(error > 0.05)
		mm1;

		num = getclientmean; 

		means= [means num];

		arr_size = arr_size + 1;
		mean_sum = mean_sum + num;
		calc_mean = mean_sum / arr_size;
		calc_std = sqrt (sumsq (means - calc_mean) / (arr_size - 1));
		auxtrust = 1.96*calc_std/sqrt(arr_size);
	
		error = 2*auxtrust/calc_mean;
		
		%err=[err error];

	endwhile
	
	ret= calc_mean;

endfunction
