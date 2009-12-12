%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo: modelo_llegadas.m
% Genera un histograma, plot q-q y aplica el test chi cuadrado a los
% datos correspondientes al "intervalo entre llegadas al sistema".
clear all;

%cargo los arribos
load arriboscop.mat

% Cargamos las horas de llegadas.
n = length(arriboscop);

% Parametros
clases = 12;		% Cant de clases para el histograma
significacion = 0.05;	% Nivel de significacion para el test chi cuadrado

% Armamos un histograma
%marcas = (0:clases) * ancho + ancho/2;
[f marcas] = hist(arriboscop, 12);

ancho = marcas(2)-marcas(1);

% Como asumimos que los datos provienen de una distribucion 
% exponencial, estimamos lambda como la inversa de la media.
lambda_est = 1 / ((f*marcas') / n)

% Calculamos los valores teoricos de la distribucion, para cada
% una de las marcas de clase.
sup = 1 - exp( -lambda_est * (marcas+ancho/2));
inf = 1 - exp( -lambda_est * (marcas-ancho/2));
teorico = n * (sup - inf);

% Generamos un set de datos con mas valores para poder graficar una curva
% mas suave en el histograma. 
dt = ancho/5;
t = 0:dt:max(marcas);
sup = 1 - exp( -lambda_est * (t+dt/2));
inf = 1 - exp( -lambda_est * (t-dt/2));
z = n * 5 * (sup - inf);

% Mostramos el grafico y lo guardamos en formato eps

figure(2);
clf;
hold on;
bar(marcas, f);
xlabel("Tiempos entre arribos al sistema [h]");
ylabel("Frecuancia absoluta");
plot(t, z, ";Modelo;");
print -deps -mono arribos_vs_model.eps 
hold off;


% Calculamos el estadistico chi cuadrado
chi_est = 0;
printf("tabla chi:\n");
for i=1:clases
	printf("%d|%f|%f|%f|%f|%f\n",i,f(i),teorico(i),teorico(i) - f(i), (teorico(i) - f(i))^2, ( ( teorico(i) - f(i) )^2 / teorico(i) ) );
	chi_est = chi_est + ((teorico(i) - f(i))^2 / teorico(i));
end
chi_est

% Calculamos el valor critico 
chi_tabla = chi2inv(1 - significacion, clases - 2)

% Imprimimos resultado del test
if chi_est >= chi_tabla
	printf("Los datos no provienen de una distribucion exponencial.\n");
else
	printf("No puedo decir que no sean de una distribucion exponencial.\n");
end

%KS
f
D = test_ks(f, teorico);

% Calculamos quantiles de la muestra y teoricos
quantil_muestra = sort(arriboscop);
quantil_teorico = (-1 / lambda_est) * log( 1 - (((1:n) - 0.5) / n));

% Los graficamos

figure(3);
clf;
hold on;
plot(quantil_muestra, quantil_teorico, '@');
print -deps -mono qqplot_arribos.eps 

n = 0:dt:1;

plot(n, n); 
xlabel("Cuantiles de la muestra");
ylabel("Cuantiles del modelo teorico");

% Aplicamos el test KS.

% Normalizo los datos en el intervalo (0, 1)
n = length(arriboscop);

% Genero un histograma

figure(4);
clf;
hist(arriboscop, 12);
[f marcas] = hist(arriboscop, clases);
print -deps -mono hist_arribos.eps 

% Computo los estadisticos
%%printf("tabla de ks:\n");

%f = f / n;
%for i=1:length(f)
%	printf("|%f",f(i));
%end
%printf("\n");



%F(1) = 0;
%for k =1:clases
%	F(k+1) = sum(f(1:k));
%end
%for i=2:length(F)
%	printf("|%f",F(i));
%end
%printf("\n");
%F

%Dmas = max(F(2:clases+1) - marcas);
%Dmenos = max(marcas - F(1:clases));
%D = max(Dmas, Dmenos)


