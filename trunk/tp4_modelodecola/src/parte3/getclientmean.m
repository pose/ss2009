function ret = getclientmean()

	[a b]=system('cat mm1.out | egrep -o "([0-9]+\.[0-9]+)" | tail -3 | head -1');

	c = index(b,"\n");
	
	b(c) = 0;

	ret = str2num(b);

endfunction
