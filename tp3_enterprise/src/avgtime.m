function [prom desv] = avgtime(cant)

	rand("seed",0);
	desv=[];
	prom=[];
	media=[];
	tstudent = 2.0930;
	for j=1:length(cant)
		for i=1:cant(j)
			iter = montecarlo(1000);
			media = [media mean(iter)];
		endfor
		auxmedia = mean(media);
		prom = [prom auxmedia]; 
		desv = [desv tstudent*std(media)/sqrt(length(media))];
	endfor
endfunction
