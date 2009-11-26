load means.mat;
load errors.mat;
xs=[1:length(a)];

plot(xs,a);

title(sprintf("Cantidad media de clientes en funcion de la cantidad de realizaciones"));
xlabel(sprintf("Cantidad de realizaciones"));
ylabel(sprintf("Cantidad media de clientes en la cola"));

print -dpng mean.png 

figure(2);

plot(xs,b);

title(sprintf("Error porcentual de la media de clientes en funcion de la cantidad de realizaciones"));
xlabel(sprintf("Cantidad de realizaciones"));
ylabel(sprintf("Error porcentual"));

print -dpng error.png 

