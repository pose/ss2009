function res = reinforcement2(t)
    res = 0;
    if ( t >= 0 && t <= 4.5 )
        res = floor(exp(t*2.5));
    end
endfunction
