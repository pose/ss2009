%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo: simulate.m
% Funcion que realiza la simulacion del sistema en funcion de la probabilidad
% p de que una unidad pase satisfactoriamente el testeo de la ST.  Retorna el tiempo medio de un cliente
% en el sistema.  El parametro max_time es el tiempo durante
% el cual se pueden generar arribos al sistema.

%Retorna
%	mean_time tiempo medio de un cliente en el sistema
%	all_delay tiempo medio espera de los clientes en cada cola
%	mean_ss ocupacion media de cada servidor
%	all_ql longitud de la cola en los instantes contenidos en all_t
%	all_t instantes en los que se registra la longitud de la cola

function [mean_time all_delay mean_ss mean_ql all_ql all_t] = simulate(p, max_time)

% Constantes
BUSY = 1;
IDLE = 0;
MAX_INT =  1.0e+030;

time = 0.0;             % Reloj de la simulacion
old_time = 0.0;             % Reloj de la simulacion previa
num_clients = 0;        % Cantidad de clientes que se fueron del sistema
ss = ones(1, 5) * IDLE; % Estado de los servidores [UI E1 E2 E3 ST]
ql = zeros(1, 3);       % Longitud de las colas [R E ST]
qds = zeros(1,3);	% Tiempo de espera en las colas [R E ST]
dt = zeros(1, 5);       % Demora acumulada en cada servidor [UI E1 E2 E3 ST]
num_events = 6;        % Numero de eventos

%[ Ra Rd E1d E2d E3d STd]
tne = ones(1, 6) * MAX_INT;    % Lista de eventos
tne(1) = time + times_generator(1);       % Primer arribo

taq{1,3} = zeros(0);    % Tiempos de llegada a cada cola por cliente

%Para graficar las colas
all_ss = [];
all_ql = [];
all_t = [];

real_ql = [];

first_time = true;
while ( time < max_time || norm(ql) > 0 || norm(ss) > 0)
	% Determina el tipo del proximo evento a ocurrir y actualiza el reloj
	[time next_event_type] = min(tne);
	
	if ( next_event_type == 0 )
		error('Lista de eventos vacia');
	end

	switch (next_event_type)   % Invoca al evento apropiado
	case 1 % Arribo a R
		[tne(2) ql(1) taq{1} ss(1) dt(1) qds(1)] = arrival(time, \
			ss(1), ql(1), taq{1}, dt(1), tne(2), 2, qds(1));
		if (time <= max_time)  % Programa prox arribo
			tne(1) = time + times_generator(1);
		else
			tne(1) = MAX_INT;
		end

	case 2 % Salida de R
		[ss(1) tne(2) ql(1) dt(1) taq{1} qds(1)] = \
		departure(ql(1), ss(1), tne(2), dt(1), taq{1}, 2, qds(1));
		
		%Si no hay que revisar el colectivo, sale del COP
		if (rand() < 0.15)	
			num_clients++;  % El cliente se va del sistema
		else
			%Pasa a los E
			
			% Si ninguna de las E esta disponible
			if ( ss(2) == BUSY && ss(3) == BUSY && ss(4) == BUSY )
				ql(2)++;
				taq{2}(ql(2)) = time;	% Guardar tiempo de arribo
			else
				[x ns] = min(ss(2:4));  % Busco ER disponible
				ns = ns + 1; 
				ss(ns) = BUSY;
				service_time = times_generator(ns+1);   % Programa partida
				tne(ns+1) = time + service_time;
				dt(ns+1) += service_time;	% Actualiza demora
			end
			
		end
	case 3  % Salida de E1
		[ss(2) tne(3) ql(2) dt(2) taq{2} qds(2)] = \	% Salida de C1
			departure(ql(2), ss(2), tne(3), dt(2), taq{2}, 3, qds(2));
		[tne(6) ql(3) taq{3} ss(5) dt(5) qds(3)] =\	% Arribo a ST
			arrival(time, ss(5), ql(3), taq{3}, dt(5), tne(6), 6, qds(3));
	case 4	% Salida de E2
		[ss(3) tne(4) ql(2) dt(3) taq{2} qds(2)] = \	% Salida de E2
			departure(ql(2), ss(3), tne(4), dt(3), taq{2}, 4, qds(2));
		[tne(6) ql(3) taq{3} ss(5) dt(5) qds(3)] =\	% Arribo a ST
			arrival(time, ss(5), ql(3), taq{3}, dt(5), tne(6), 6, qds(3));
	case 5 % Salida de E3
		[ss(4) tne(5) ql(2) dt(4) taq{2} qds(2)] = \	% Salida de E3
			departure(ql(2), ss(4), tne(5), dt(4), taq{2}, 5, qds(2));
		[tne(6) ql(3) taq{3} ss(5) dt(5) qds(3)] =\	% Arribo a ST
			arrival(time, ss(5), ql(3), taq{3}, dt(5), tne(6), 6, qds(3));
	case 6 % Salida de ST
		[ss(5) tne(6) ql(3) dt(5) taq{3} qds(3)] = departure(ql(3), \
		ss(5), tne(6), dt(5), taq{3}, 6, qds(3));
		
		if (rand() < p)
		  num_clients++;	% El cliente se va del sistema.
		else
			%Debe volver a las Es
			% Si ninguna de las E esta disponible
			if ( ss(2) == BUSY && ss(3) == BUSY && ss(4) == BUSY )
				ql(2)++;
				taq{2}(ql(2)) = time;	% Guardar tiempo de arribo
			else
				[x ns] = min(ss(2:4));  % Busco ER disponible
				ns = ns + 1; 
				ss(ns) = BUSY;
				service_time = times_generator(ns+1);   % Programa partida
				tne(ns+1) = time + service_time;
				dt(ns+1) += service_time;	% Actualiza demora
			end

		end
	end
	
	if (first_time)
	    applied_ss = ss;
	    applied_ql = ql;
	    
	    first_time = false;
	else
	    applied_ss = ss * (time - old_time);
	    applied_ql = ql * (time - old_time);
	end
	
	all_ss=[all_ss ; applied_ss];
	all_ql=[all_ql ; ql];
	all_t=[all_t time];
	
	real_ql=[real_ql ; applied_ql];
	
	old_time = time;
end
mean_time = sum(dt) / num_clients;
all_delay = qds / num_clients;

%Se computa el tiempo medio de ocupacion de los servidores
for i = 1:columns(all_ss)
    mean_ss(i) = sum(all_ss(:,i)') / time;
end
%Se computa la longitud media de las colas
for i = 1:columns(real_ql)
    mean_ql(i) = sum(real_ql(:,i)') / time;
end

%printf('Mean Time %d %d es %d\n',sum(dt),num_clients, sum(dt) / num_clients);
%printf('Espera en las colas %d %d %d \n',all_delay(1),all_delay(2),all_delay(3));
%printf('Ocupacion de los ERs %f %f %f \n',mean_ss(2),mean_ss(3),mean_ss(4));
%printf('Longitud media de las colas %f %f %f \n',mean_ql(1),mean_ql(2),mean_ql(3));
%fflush(1);
end
