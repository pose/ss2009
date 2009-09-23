function y = u_not_so_dummy(t, x1)
    global r;
    
    y = feval(r,t) - x1;
endfunction
