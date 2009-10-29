function [prom desv] = avgtime(cant)

	rand("seed",0);
	desv=[];
	prom=[];
	media=[];
	for j=1:length(cant)
		for i=1:cant(j)
			iter = montecarlo(1000);
			media = [media mean(iter)];
		endfor
		prom = [prom mean(media)]; 
		desv = [desv std(media)];
	endfor
endfunction
