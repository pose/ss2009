function ret = unfrec(frecs, marks, n) 

    frec_relativas = round( ( frecs./sum(frecs) ) * n );
  
    if (sum(frec_relativas) != n )
      frec_relativas(1)=frec_relativas(1)+n-sum(frec_relativas);
    endif
    
    resultset=[];
    for i=1:columns(frec_relativas)
	for j=1:frec_relativas(i)
	  resultset=[resultset marks(i)];
	endfor
    endfor

    ret = resultset;
endfunction
