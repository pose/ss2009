function res = reinforcement4(t)
    res = 0;
    if ( 0 <= t && 1 > t )
        res = 54000;
    end
    if (20 <= t && 21 > t)
       res = 6000;
    end
    if ( 35 <= t && 36 > t )
        res = 13000;
    end
endfunction
