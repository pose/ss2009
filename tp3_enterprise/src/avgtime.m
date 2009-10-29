function [prom desv err] = avgtime(cant)

	rand("seed",0);
	desv=[];
	prom=[];
	media=[];
	err=[];
	tstudent = 1.6;
	for j=1:length(cant)
		for i=1:cant(j)
			iter = montecarlo(1000);
			media = [media mean(iter)];
		endfor
		auxmedia = mean(media);
		prom = [prom auxmedia];
		auxtrust = 2*tstudent*std(media)/sqrt(length(media));
		desv = [desv auxtrust];
		err = [err 2*auxtrust/auxmedia];
	endfor
endfunction
