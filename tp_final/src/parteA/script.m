load arriboscop.mat
load ercop.mat
load ercopdata.mat

%set term win;
figure(1);
hist(arriboscop,12);
xlabel("Intervalos de clase");
ylabel("Cantidad de arribos en la clase");
title("Histograma del tiempo entre arribo de unidades");
print -deps hist_arribos.eps 

figure(2);
hist(ercopdata,ercop(:,1)');
xlabel("Intervalos de clase");
ylabel("Cantidad de unidades atendidas");
title("Histograma del tiempo de atencion de unidades");
print -deps hist_servicios.eps 