function res = poseplot(data, config)

    figure();
    parsed_config = load_json(config);

    hold off
    
   
    if (isfield(parsed_config, 'references'))
        for i=parsed_config.references
            s = '';

            if (isfield(i{1}, 'id'))
                id = i{1}.id;
            else
                continue;
            endif
            if (isfield(data,id) && isfield(getfield(data,id), 'x') && 
                isfield(getfield(data,id), 'y') )
                x = getfield(data,id).x;
                y = getfield(data,id).y;
            else
                continue;
            endif
            if (isfield(i{1},'symbol'))
                s = i{1}.symbol;
            endif
            if ( isfield(i{1}, 'name') )
                s = strcat(s, ';', i{1}.name , ';');
            endif 
            plot (x, y, s);
            hold on
        endfor
    endif
    hold off

    
    if ( isfield( parsed_config,'title' ) )
        title (parsed_config.title);
    endif


    if ( isfield( parsed_config,'axis' ) )
        if ( isfield( parsed_config.axis ,'x') )
            xlabel (parsed_config.axis.x);
        endif
        if ( isfield( parsed_config.axis ,'y') )
            ylabel (parsed_config.axis.y);
        endif
    endif

    if ( isfield(parsed_config,'grid' ) )
        if (parsed_config.grid)
            grid("on");
        else
            grid("off");
        endif
    endif

    if ( isfield( parsed_config,'output') )
        if(isfield(parsed_config.output,'filename') && isfield( parsed_config.output,'type'))
            print(parsed_config.output.filename,  ['-d', parsed_config.output.type])
        endif
    endif
    

endfunction
