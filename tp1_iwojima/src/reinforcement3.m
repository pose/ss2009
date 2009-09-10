function res = reinforcement3(t)
    res = 0;
    if ( t >= 0 && t <= 6 )
        res = 54000 - floor(t*9000);
    end
endfunction
