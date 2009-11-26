function [ret err] = parte3()

	mm1;
	ret=[getclientmean];
	
	error=1;
	err=[1];
	while(error > 0.05)
		mm1;

		num = getclientmean; 

		ret= [ret num];

		auxtrust = 2*1.6*std(ret)/sqrt(length(ret));
		error = 2*auxtrust/mean(ret);
		err=[err error];
		%chequear el calculo del error
		%error = std(ret)/mean(ret);
	

	endwhile
	
endfunction
