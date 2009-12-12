%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo STStressTest.m
% Computa el punto e).

rand('seed', 1000);

%160 Hs
max_time = 9600;

[delay{1} delay_error{1} ss{1} ss_error{1} ql{1} ql_error{1}] = STStressTest_helper(0.05, max_time);
for i = 2:20
	p = 0.05 * i;
	[delay{i} delay_error{i} ss{i} ss_error{i} ql{i} ql_error{i}] = STStressTest_helper(p, max_time);
end

p = .05:.05:1.0;

for i = 1:20
	delay_UI(i) = delay{i}(1);
	delay_ER(i) = delay{i}(2);
	delay_ST(i) = delay{i}(3);

	ss_ER1(i) = ss{i}(1);
	ss_ER2(i) = ss{i}(2);
	ss_ER3(i) = ss{i}(3);

	ql_UI(i) = ql{i}(1);
	ql_ER(i) = ql{i}(2);
	ql_ST(i) = ql{i}(3);
end

figure(1);
plot(p,delay_UI);
xlabel('Probablidad de pasar el test de la ST');
ylabel('Tiempo promedio en la cola(minutos)');
title('Tiempo promedio en la cola de la UI en funcion de la probabilidad de pasar el test de la ST');
print -deps -mono tp_UI.eps

figure(2);
plot(p,delay_ER);
xlabel('Probablidad de pasar el test de la ST');
ylabel('Tiempo promedio en la cola(minutos)');
title('Tiempo promedio en la cola de la ER en funcion de la probabilidad de pasar el test de la ST');
print -deps -mono tp_ER.eps

figure(3);
plot(p,delay_ST);
xlabel('Probablidad de pasar el test de la ST');
ylabel('Tiempo promedio en la cola(minutos)');
title('Tiempo promedio en la cola de la ST en funcion de la probabilidad de pasar el test de la ST');
print -deps -mono tp_ST.eps


figure(4);
plot(p,ss_ER1);
xlabel('Probablidad de pasar el test de la ST');
ylabel('Ocupacion promedio del servidor(%)');
title('Ocupacion promedio del servidor ER1 en funcion de la probabilidad de pasar el test de la ST');
print -deps -mono ss_ER1.eps

figure(5);
plot(p,ss_ER2);
xlabel('Probablidad de pasar el test de la ST');
ylabel('Ocupacion promedio del servidor(%)');
title('Ocupacion promedio del servidor ER2 en funcion de la probabilidad de pasar el test de la ST');
print -deps -mono ss_ER2.eps

figure(6);
plot(p,ss_ER3);
xlabel('Probablidad de pasar el test de la ST');
ylabel('Ocupacion promedio del servidor(%)');
title('Ocupacion promedio del servidor ER3 en funcion de la probabilidad de pasar el test de la ST');
print -deps -mono ss_ER3.eps

figure(7);
plot(p,ql_UI);
xlabel('Probablidad de pasar el test de la ST');
ylabel('Longitud promedio de la cola(minutos)');
title('Longitud promedio de la cola de la UI en funcion de la probabilidad de pasar el test de la ST');
print -deps -mono ql_UI.eps

figure(8);
plot(p,ql_ER);
xlabel('Probablidad de pasar el test de la ST');
ylabel('Longitud promedio de la cola(minutos)');
title('Longitud promedio de la cola de la ER en funcion de la probabilidad de pasar el test de la ST');
print -deps -mono ql_ER.eps

figure(9);
plot(p,ql_ST);
xlabel('Probablidad de pasar el test de la ST');
ylabel('Longitud promedio de la cola(minutos)');
title('Longitud promedio de la cola de la ST en funcion de la probabilidad de pasar el test de la ST');
print -deps -mono ql_ST.eps



