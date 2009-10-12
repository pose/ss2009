function ret = test_ks(nums, intervals)

        #check if the entry is a row vector
        if (rows(nums) > 1)
                error('nums must be an array');
        endif
        if (intervals < 2)
                error('the number of intervals must be at least two');
        endif

        #use an array to store the frecuency of each number in a category
        frecuencyArray=zeros(intervals,1)';

        for i=1:intervals
                frecuencyArray(floor(nums(i)/(1/intervals))+1)++;
        endfor

	dPlusArray = zeros(intervals,1)';
	for i=1:intervals
		dPlusArray(i)=i/intervals - frecuencyArray(i)/columns(nums);
	endfor

	dMinusArray = zeros(intervals,1)';
	
	for i=1:intervals
		dMinusArray(i)=frecuencyArray(i)/columns(nums);
		if i != 1
			dMinusArray(i)-=(i-1)/intervals;
		endif
	endfor

	ret=max(max(dPlusArray),max(dMinusArray));
	
endfunction
