# función de fuerzas norteamericanas reales
function r = american(t)

    r = [];
    if length(t) > 1
        for i=1:length(t)
            r(i) = american(t(i));
        endfor
        return;
    end

    r = 0;
    if (t >= 7 && t < 9)
        r = 66000;
    elseif (t>=9 && t < 12)
        r = 62000;
    elseif (t>=12 && t < 19)
        r = 58500;
    elseif (t>=19 )
        r = 54000;
    end
endfunction
