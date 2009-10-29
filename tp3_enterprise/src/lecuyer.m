# L'evuyer method for generating pseudo random numbers
# Input : seed for generator 1, seed for generator 2, desired amount of numbers

function u = lecuyer(s1, s2, n)
	# m value for generator 1
	m1=2147483563;
	# m value for generator 2
	m2=2147483399;
	
	s1=mod(s1,m1);
	s2=mod(s2,m2);

	#seeds validation	
	if (m1<=s1 || s1<1)
		error('invalid s1 seed');
	endif
	if (m2<=s2 || s2<1)
		error('invalid s2 seed');
	endif
	
	u=[];
	x1=s1;
	x2=s2;

	for i=1:n
		# generator 1
		x1 = mod(40014*x1,m1);
		#generator 2
		x2 = mod(40692*x2, m2);

		#lecuyer method
		xn = mod(x1-x2,m1-1);
		lastgen=0;
		if (xn > 0)
			lastgen=x1/m1;	
		else
			lastgen=(m1-1)/m1;
		endif

		# solution array
		u = [u lastgen];	
	endfor

endfunction
