function [res err] = load_json(file)
    if ( (f = fopen(file)) == -1 )
        res = {};
        err = 1;
    endif

    final_s = "";
    while ((s = fgets(f))!= -1)
        final_s = strcat(final_s, s);
    endwhile

    fclose(f);
    res = json2octave(final_s);
endfunction
