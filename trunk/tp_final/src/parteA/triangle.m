function y = triangle(x,a,b,c)

	if (c<b || b<a)
		error('parameters must follow the rule a<b<c');
	endif

	if ( a <= x && x <= b )
		y = (2*(x-a))/((b-a)*(c-a));
	elseif ( b < x && x <= c )
		y = (2*(c-x))/((c-b)*(c-a));
	else
		y = 0;
	endif
endfunction
