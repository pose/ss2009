function res = json2octave(json)
    s = regexprep(json, '\s+', ' ');
    s = regexprep(s, '{', 'struct(');
    s = regexprep(s, '}', ')');
    s = regexprep(s, '\[', '{{');
    s = regexprep(s, '\]', '}}');
    s = regexprep(s, '([^\s]+):', '"$1",');
    res = eval(s) ;
endfunction
