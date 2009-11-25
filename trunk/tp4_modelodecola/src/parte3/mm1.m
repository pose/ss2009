% Octave script: mm1.m
% Proposito:     Simula una cola M/M/1
%
% Declaracion de constantes y variables:
clear all

global Q_LIMIT = 100;
global BUSY    = 1;
global IDLE    = 0;

global next_event_type;
global num_custs_delayed;
global num_delays_required;
global num_events;
global num_in_q;
global server_status1;
global server_status2;

global area_num_in_q;
global area_server_status;
global mean_interarrival;
global mean_service1;
global mean_service2;
global time;
global time_arrival;
global time_last_event;
global time_next_event;
global total_of_delays;

% Abre los archivos I/O
inpfile = fopen('mm1.inp','r');
outfile = fopen('mm1.out','w');
timfile = fopen('mm1.tim','w');

% Especifica el numero de eventos
num_events = 3;

% Lee el archivo de entrada
xdata = fscanf(inpfile,'%f %f %f %f',[1 4]);
mean_interarrival   = xdata(1);
mean_service1        = xdata(2);
mean_service2        = xdata(3);
num_delays_required = xdata(4);
 

% Escribe los encabezados de los reportes y parametros de entrada
fprintf(outfile,'Sistema de cola de servidor simple\n\n');
fprintf(outfile,'Tiempo medio entre arribos %11.3f minutos\n\n',mean_interarrival);
fprintf(outfile,'Tiempo medio de servicio 1   %11.3f minutos\n\n',mean_service1);
fprintf(outfile,'Tiempo medio de servicio 2   %11.3f minutos\n\n',mean_service2);
fprintf(outfile,'Numero de clientes         %14d\n\n', num_delays_required);

fprintf(timfile,'Series de tiempo producidas por mm1.m \n');
fprintf(timfile,'3\n');
fprintf(timfile,'time\n');
fprintf(timfile,'longitud de la cola\n');
fprintf(timfile,'ocupacion del servidor (OCUPADO=1,LIBRE=0)\n');

% Inicializa la simulacion
initialize();

% Corre la simulacion
while ( num_custs_delayed < num_delays_required )
	fprintf(timfile, "%16.3f %d %d %d\n",time,num_in_q,server_status1,server_status2);
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
			depart1();
			%break;
		case 3
			depart2();
			%break;			
	endswitch
endwhile

% Invoca al generador de reportes y fin de la simulacion
report(outfile);
fclose(inpfile);
fclose(outfile);
fclose(timfile);

	
	
