function ret = parte3()

	mm1;
	ret=[getclientmean];
	
	error=1;
	while(error > 0.05)
		mm1;

		num = getclientmean; 

		ret= [ret num];

		%chequear el calculo del error
		error = std(ret)/mean(ret);
	

	endwhile
	
endfunction
