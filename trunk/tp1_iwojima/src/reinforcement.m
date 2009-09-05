function res = reinforcement(t)
    res = 0;
    if ( 0 <= t && 1 > t )
        res = 54000;
    end
    if (2 <= t && 3 > t)
       res = 6000;
    end
    if ( 5 <= t && 6 > t )
        res = 13000;
    end
endfunction
