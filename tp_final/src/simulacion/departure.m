%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo: departure.m
% Salida de un cliente de un servidor con una unica cola simple.  Recibe 
% varias variables de estado de simulate.m y retorna en su nombre los
% valores actualizados de las mismas luego de la salida del cliente.
%
% Parametros de entrada:
%  - ql             Longitud de la cola del servidor al que llega el cliente
%  - ss             Estado del servidor al que llega el cliente
%  - tne_depart     Tiempo de partida del prox cliente en este servidor
%  - dt             Retardo acumulado en este servidor de todos los clientes
%  - taq            Vector de tiempos de llegadas de los clientes a esta cola
%  - dep_event_type Tipo de evento de salida de este servidor
%  - qds         Tiempo acumulado de espera en la cola

function [ss tne ql dt taq qds] = departure(ql, ss, tne, dt, taq, dep_event_type, qds)

	% Constantes
	BUSY    = 1;
	IDLE    = 0;
	MAX_INT =  1.0e+030;

	time = tne;

	if ( ql == 0)	% La cola esta vacia
		ss = IDLE;
		tne = MAX_INT;
	else	% Atender nuevo cliente
		service_time = times_generator(dep_event_type);
		tne = time + service_time;
		delay = time - taq(1);
		dt += delay + service_time;
		qds += delay;           % El delay es el tiempo que espero en la cola
		taq = shiftl(taq);	% Mover clientes 1 lugar
		ql--;
	end
end
