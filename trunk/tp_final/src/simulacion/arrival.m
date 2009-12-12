%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo: arrival.m
% Arribo de un cliente a un servidor con una unica cola simple.  Recibe 
% varias variables de estado de simulate.m y retorna en su nombre los
% valores actualizados de las mismas luego del arribo del cliente.
% 
% Parametros:
%  - time        Reloj actual de la simulacion
%  - ss          Estado del servidor al que llega el cliente
%  - ql          Longitud de la cola del servidor al que llega el cliente
%  - taq         Vector de tiempos de llegadas de los clientes a esta cola
%  - dt          Retardo acumulado en este servidor de todos los clientes
%  - tne_depart  Tiempo de partida del prox cliente en este servidor
%  - devent_type Tipo de evento de salida de este servidor

function [tne_depart ql taq ss dt qds] = \
	arrival(time, ss, ql, taq, dt, tne_depart, devent_type, qds)

	% Constantes
	BUSY    = 1;
	IDLE    = 0;

	if ( ss == BUSY )
		ql++;           % Encolar cliente
		taq(ql) = time;	% Guardar tiempo de arribo
	else
		ss = BUSY;
		service_time = times_generator(devent_type); % Programar partida
		tne_depart = time + service_time;
		dt += service_time;                % Actualizar demora
	end
end
