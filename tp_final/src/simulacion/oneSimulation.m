%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo oneSimulation.m
% Computa el punto c).

format long;
rand('seed',1000);

%50 Hs
[mean_time xx yy zz all_ql all_t] = simulate(0.6, 3000 );

figure(1);
plot(all_t,all_ql(:,1));
xlabel('Instante de la simulacion(minutos)');
ylabel('Longitud de la cola(personas)');
title('Longitud de la cola de la Unidad de Inspeccion a lo largo de la simulacion');
print -deps -mono cola_UI.eps

figure(2);
plot(all_t,all_ql(:,2));
xlabel('Instante de la simulacion(minutos)');
ylabel('Longitud de la cola(personas)');
title('Longitud de la cola de las Estaciones de Reparacion a lo largo de la simulacion');
print -deps -mono cola_ER.eps

figure(3);
plot(all_t,all_ql(:,3));
xlabel('Instante de la simulacion(minutos)');
ylabel('Longitud de la cola(personas)');
title('Longitud de la cola del Sector de Testeo a lo largo de la simulacion');
print -deps -mono cola_ST.eps
