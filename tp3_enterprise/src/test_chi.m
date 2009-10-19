# test_chi
# function to evaluate uniform random-number generators
function chi = test_chi(numbers,intervals)

        #check if the entry is a row vector
        if (rows(numbers) > 1)
                error('numbers must be an array');
        endif
        if (intervals < 2)
                error('the number of intervals must be at least two');
        endif

        #use an array to store the frecuency of each number in a category
        frecuencyArray=zeros(intervals,1)';

        for i=1:columns(numbers)
                frecuencyArray(floor(numbers(i)/(1/intervals))+1)++;
        endfor
	
	#debugging print (removing ;)
	frecuencyArray;

	#expected value for an uniform distribution
	expectedValue=columns(numbers)/intervals;
	
	chi=0;
	for i=1:columns(frecuencyArray)
		chi+=pow2(frecuencyArray(i)/expectedValue-1)/expectedValue;
	endfor

endfunction

