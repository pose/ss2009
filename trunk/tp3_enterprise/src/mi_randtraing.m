function ret = mi_randtraing(u,a,b,c)
	if (c<b || b<a)
		error('parameters must follow the rule a<b<c');
	endif
	ret=[];
	for i=1:columns(u)
		if ( u(i) >= 0 && u(i) <= (b-a)/(c-a) ) 
			newval = sqrt(u(i)*(b-a)*(c-a))+a;			
		elseif (u(i) > (b-a)/(c-a) && u(i) <= 1)
			newval= -sqrt(-u(i)*(c-a)*(c-b)+(b-a)*(c-b)+pow2(c-b))+c;
		else
			error('invalid u value');
		endif
		ret = [ret newval];
	endfor

endfunction
