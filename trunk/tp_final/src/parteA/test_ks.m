function ret = test_ks(empirical, teorical)

	empirical = empirical./sum(empirical);
	teorical = teorical./sum(teorical);
	
	for i = 2:length(teorical)
		teorical(i)=teorical(i)+teorical(i-1);
	end

	printf("tabla del ks\n");
	for i=1:length(empirical)
		printf("|%f",empirical(i));
	end
	printf("\n");
	for i=1:length(teorical)
		printf("|%f",teorical(i));
	end
	printf("\n");


	#use an array to store D+ values 
	for i=1:length(empirical)
		dPlusArray(i)=teorical(i) - empirical(i);
	endfor

	for i=1:length(dPlusArray)
		printf("|%f",dPlusArray(i));
	end
	printf("\n");

	#use an array to store D- values
	dMinusArray = zeros(length(empirical),1)';
	for i=1:length(empirical)
		dMinusArray(i)=empirical(i);
		if i != 1
			dMinusArray(i)-=(i-1)/length(empirical);
		endif
	endfor

	for i=1:length(dMinusArray)
		printf("|%f",dMinusArray(i));
	end
	printf("\n");

	#response value for kolmogorof-smirnov test
	dplus=max(dPlusArray)
	dminus=max(dMinusArray)
	ret=max(max(dPlusArray),max(dMinusArray));
	
endfunction
