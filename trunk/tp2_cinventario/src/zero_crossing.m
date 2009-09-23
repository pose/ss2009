#Evento que se dispara si alguna de las dos funciones cruza el 0
function [veve, vterm, vdir] = zero_crossing (vt, vy, varargin)
  veve = min(vy(1),vy(2)); ## Which event component should be tread
  vterm =     1; ## Terminate if an event is found
  vdir = -1;
endfunction
