# Este es el "iwojima.m" de este tp jaja

global K; 

K = 0.0052;

global r;
function y = my_r(t)
    y = 50;
endfunction

r = 'my_r';

global u;

j = 1;
s = '+o^*-';
#for K=0.001:.0509:1
k_plot.k_1.x = 0:5;
k_plot3.k_1.x = 0:5;
lazo_abierto.k_1.x = 0:5;
lazo_abierto2.k_1.x = 0:5;


j = 1;
u = 'u_dummy';
for K=linspace(0.01,0.01,1)
    [t units sales_rate] = deposit_simulator(5, 1, 2);
    label = sprintf("K = %g",K);
    lazo_abierto = setfield(lazo_abierto, sprintf('k_%d', j),'x',t);
    lazo_abierto = setfield(lazo_abierto, sprintf('k_%d', j),'y',units);
    lazo_abierto = setfield(lazo_abierto, sprintf('k_%d', j),'label',label);
    lazo_abierto2 = setfield(lazo_abierto2, sprintf('k_%d', j),'x',t);
    lazo_abierto2 = setfield(lazo_abierto2, sprintf('k_%d', j),'y',sales_rate);
    lazo_abierto2 = setfield(lazo_abierto2, sprintf('k_%d', j),'label',label);
    j++;
    hold on
endfor
poseplot(lazo_abierto, 'lazo_abierto.json');
poseplot(lazo_abierto2, 'lazo_abierto2.json');



global K;
global u;
u = 'u_not_so_dummy';
j = 1;
for K=linspace(0,0.18,5)
    [t units sales_rate] = deposit_simulator(10, 5, 20);
    label = sprintf("K = %g",K);
    k_plot = setfield(k_plot, sprintf('k_%d', j),'x',t);
    k_plot = setfield(k_plot, sprintf('k_%d', j),'y',units);
    k_plot = setfield(k_plot, sprintf('k_%d', j),'label',label);
    k_plot3 = setfield(k_plot3, sprintf('k_%d', j),'x',t);
    k_plot3 = setfield(k_plot3, sprintf('k_%d', j),'y',sales_rate);
    k_plot3 = setfield(k_plot3, sprintf('k_%d', j),'label',label);
    j++;
    hold on
endfor
poseplot(k_plot, 'k_plot.json');
poseplot(k_plot3, 'k_plot3.json');


function y = my_r(t)
    y = 100000;
endfunction

j = 1;
k_plot2.k_1.x = 0:5;
for K=logspace(0.001,.5,5)-1
    [t units sales_rate] = deposit_simulator2(20000, 100, 10);
    k_plot2 = setfield(k_plot2, sprintf('k_%d', j),'x',t);
    k_plot2 = setfield(k_plot2, sprintf('k_%d', j),'y',units);
    label = sprintf("K = %g",K);
    k_plot2 = setfield(k_plot2, sprintf('k_%d', j),'label',label);
    j++;
    hold on
endfor
poseplot(k_plot2, 'k_plot2.json');

    
