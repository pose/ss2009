% Matlab script: mm1.m
% Proposito: Simula un modelo de cola con servidor simple del tipo
%			  M/M/1 con disciplina FIFO.
%			  Lee el archivo de entrada mm1.inp donde en el primer registro
%			  aparecen, separados por espacios: tiempo medio entre arribos, 
%			  tiempo medio de servicio y numero de clientes total procesados.
%			  La salida de la simulacion se da en dos archivos:
%			  mm1.out: Muestra valores estadisticos computados
%			  mm1.tim: Muestra la series de tiempo resultado de la simulacion
%			  
%			  Adaptado de "Simulation Modeling & Analysis",
%			  Law y Kelton.Proposito:     
%				%Simula una cola M/M/1
%
% Funciones utilizadas:
% arrive.m
% depart.m
% expon.m
% initialize.m
% report.m
% timing.m
% update_time_avg_stats.m
%
% Autor: Alejandro Diaz
% Declaracion de constantes y variables:
function [rho, relativeError, meanQueueWait] = mm1(lambda, mu, amount)

%clear all

global Q_LIMIT;
global BUSY;
global IDLE;

global next_event_type;
global num_custs_delayed;
global num_delays_required;
global num_events;
global num_in_q;
global server_status;

global area_num_in_q;
global area_server_status;
global mean_interarrival;
global mean_service;
global time;
global time_arrival;
global time_last_event;
global time_next_event;
global total_of_delays;


%Set parameters
mean_interarrival = lambda;
mean_service = 1/mu;
num_delays_required = amount;

maxSize = 100;

rho = 0.0;
%TOLEEEEE
tole = 0.05;

relativeError = zeros(1, maxSize);
relativeError(1) = 1.0;
relativeError(2) = 1.0;

queueWait = 0.0;
queueWaits = zeros(1, maxSize);
meanQueueWait = 0.0;

%

Q_LIMIT = maxSize; % 100;

BUSY    = 1;
IDLE    = 0;



% Especifica el numero de eventos
num_events = 2;
rho = mean_service * mean_interarrival;

% Inicializa la simulacion
initialize();
i = 1;

%% simulate the queue:
while( (relativeError(i) > tole) && (i < maxSize) )
    i = i + 1;
    % Corre la simulacion
    while ( num_custs_delayed < num_delays_required )
	%fprintf(timfile, '%16.3f %d %d\n',time,num_in_q,server_status);
	% Determina el proximo evento
      timing();
	% Actualiza los acumuladores estadisticos de tiempos medios
      update_time_avg_stats();
        % Invoca al evento apropiado
        switch (next_event_type)
            case 1
                arrive();
                %break;

            case 2
                depart();
                %break;
        end
    end
    queueWait = total_of_delays / num_custs_delayed;
    queueWaits(i-1) = queueWait;
    meanQueueWait = mean(queueWaits(1:i-1));
    if (i > 2)
      auxtrust = 2*1.6*std(queueWaits(1:i-1))/sqrt(i-1);
      relativeError(i)=2*auxtrust/meanQueueWait;
    end
    initialize();
    %queueLength = area_num_in_q / time;
    % store the currente length value ...
    %queueLengths(i-1) = queueLength;
    % calculate the mean of the queue length ...
    %meanQueueLength = mean(queueLengths(1:i-1));
    %if(i > 2)
        %student's t analysis (t_s = 1.6) 
%	auxtrust = 2*1.6*std(queueLengths(1:i-1))/sqrt(i-1);
%	relativeError(i) = 2*auxtrust/meanQueueLength;
        %relativeError(i) = std(queueLengths(1:i-1)) / meanQueueLength;
%    end
%    initialize();  
end
relativeError = relativeError(1:i);
endfunction
