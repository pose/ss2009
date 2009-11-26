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
%			  Adaptado de "Simulation Modeling & Analysis", Law y Kelton.Proposito:     Simula una cola M/M/1
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
function [dRho, dRelError, mean_L] = mm1(meanVals)

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

iMaxSize = 1500; % max. size of the arrays (buffer size) ...

iNClients = 100; % number of clients (standard value) ...
dRho = 0.0; % traffic intensity value of the system ...
dError = 0.05; % break condition ...

dRelError = zeros(1, iMaxSize); % array of all relative errors of the given system ...
dRelError(1) = 1.0; % initialization (first value) ...
dRelError(2) = 1.0;

L = 0.0; % current length of queue ...
a_L = zeros(1, iMaxSize); % array to save all current queue length ...
mean_L = 0.0; % mean of all queue length a_L ...
%dConf = 0.0; % confidence interval value ...

%
Q_LIMIT = iMaxSize; % 100;
BUSY    = 1;
IDLE    = 0;

% Especifica el numero de eventos
num_events = 2;

if(~isempty(meanVals))
    mean_interarrival   = meanVals(1); % mean of arrival time (lambda) ...
    mean_service        = meanVals(2); % mean of service time (mu) ...
    num_delays_required = iNClients; % using std. 
    
    % calculate the traffic densitiy ...
%     f_lambda = 1.0/mean_interarrival;
%     f_mu = 1.0/mean_service;
%     dRho = f_lambda/f_mu;
    dRho = mean_service/mean_interarrival;
else
    % Abre los archivos I/O
    inpfile = fopen('mm1.inp','r');
    outfile = fopen('mm1.out','w');
    timfile = fopen('mm1.tim','w');

    % Lee el archivo de entrada
    xdata = fscanf(inpfile,'%f %f %f',[1 3]);
    mean_interarrival   = xdata(1);
    mean_service        = xdata(2);
    num_delays_required = xdata(3);

    % Escribe los encabezados de los reportes y parametros de entrada
    fprintf(outfile,'Sistema de cola de servidor simple\n\n');
    fprintf(outfile,'Tiempo medio entre arribos %11.3f minutos\n\n',mean_interarrival);
    fprintf(outfile,'Tiempo medio de servicio   %11.3f minutos\n\n',mean_service);
    fprintf(outfile,'Numero de clientes         %14d\n\n', num_delays_required);

    fprintf(timfile,'Series de tiempo producidas por mm1.m \n');
    fprintf(timfile,'3\n');
    fprintf(timfile,'time\n');
    fprintf(timfile,'longitud de la cola\n');
    fprintf(timfile,'ocupacion del servidor (OCUPADO=1,LIBRE=0)\n');
end

% Inicializa la simulacion
initialize();

iCount = 1;
% print initial relative error ...
%fprintf('rel. error(%d): %f\n', iCount, dRelError(iCount));

%% simulate the queue:
while( (dRelError(iCount) > dError) && (iCount < iMaxSize) )
    % count up ...
    iCount = iCount + 1;
    
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
    %L = area_num_in_q / time; % false ...
    L = (area_num_in_q + area_server_status) / time; % correct ...
    % store the currente length value ...
    a_L(iCount-1) = L; % CHECK ...
      
    % calculate the mean of the queue length ...
    mean_L = mean(a_L(1:iCount-1));

    % calculate the confidence interval ...
    %dConf = std(a_L(1:iCount)) / sqrt(length(a_L(1:iCount)));
 
    % calculate the relative error ...
    %dRelError(iCount) = 1.6*dConf / mean_L;
    if(iCount > 2)
        %dRelError(iCount) = 1.6*std(a_L(1:iCount-1)) / (mean_L*sqrt(iCount)); % makes the simulation more accurate ...
        dRelError(iCount) = std(a_L(1:iCount-1)) / mean_L; % makes the simulation more accurate ...
    end
        
    % print the current relative error ...
    %fprintf('rel. error(%d): %f\n', iCount, dRelError(iCount));
    %fprintf('rel. error(%d): %f,  STD(a_L):  %f, mean_L: %f  L: %f\n', ...
    %           iCount, dRelError(iCount), std(a_L(1:iCount-1)), mean_L, L);

    initialize();  
end

fprintf('\ntotal steps: %d\n', iCount);

% cut the array at the count position (all data behind are zero) ...
dRelError = dRelError(1:iCount);

if(isempty(meanVals))
    % Invoca al generador de reportes y fin de la simulacion
    report(outfile);
    fclose(inpfile);
    fclose(outfile);
    fclose(timfile);
end


































% Octave script: mm1.m
% Proposito:     Simula una cola M/M/1
%
% Declaracion de constantes y variables:

%clear all
		  %lambda	     %mu
function [rho,meanQueueLength] = mm1(mean_interarrival, mean_service, num_delays_required)

global Q_LIMIT = 100;
global BUSY    = 1;
global IDLE    = 0;

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

% Especifica el numero de eventos
num_events = 2;


%Initialize Parameters
maxSize = 1500;

%la TOLEEEEEEE
tole = 0.05;

relativeError = zeros(1, maxSize);
relativeError(1) = 1.0;
relativeError(2) = 1.0;

queueLength = 0.0;
queueLengths = zeros(1, maxSize);
meanQueueLength = 0.0;

rho = mean_interarrival / mean_service;

% Inicializa la simulacion
initialize();

i = 1;

while( (relativeError(i) > tole) && (i < maxSize) )

	% Corre la simulacion
	while ( num_custs_delayed < num_delays_required )
		fprintf(timfile, "%16.3f %d %d\n",time,num_in_q,server_status);
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
		endswitch
		

		queueLength = area_num_in_q / time;
		queueLengths(i-1) = queueLength;
		meanQueueLength = mean(queueLengths(1:i-1));

		%Compute error
		if(i > 2)
			relativeError(i) = std(queueLengths(1:i-1)) / meanQueueLength;
		end

	endwhile

endwhile

endfunction