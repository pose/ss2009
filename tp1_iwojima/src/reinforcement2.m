function res = reinforcement2(t)
    res = 0;
    if ( t >= 0 && t <= 4.6 )
        res = floor(exp(t*2.5)) + 2000;
    end
endfunction
