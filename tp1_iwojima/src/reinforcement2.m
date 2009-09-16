function res = reinforcement(t)
    res = 0;
    if ( 0 <= t && 1 > t )
        res = 30000;
    end
    if (4 <= t && 5 > t)
       res = 3000;
    end
    if ( 7 <= t && 8 > t )
        res = 1000;
    end
endfunction
