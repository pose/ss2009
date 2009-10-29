function ret = montecarlo(cant)
	%u = lecuyer(s1,s2,cant*5);
	u = rand(cant*5,1)';
	ret=0;

	for i=1:length(cant)
		ret += min([ max(30*u(i)+20,7*u(i+cant)+5) max( -240*log(1-u(i+cant*2)), -240*log(1-u(i+cant*3)) ) (60*u(i+cant*4)+12)]);
	endfor
endfunction
