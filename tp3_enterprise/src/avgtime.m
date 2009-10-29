function media = avgtime(cant)

	rand("seed",0);
	
	ret=[ ];
	media=[ ];

	for j=1:length(cant)
		for i=1:cant(j)
			ret = [ ret montecarlo(1000)];
		endfor 
		media = [media sum(ret)/length(ret)];
	endfor
endfunction
