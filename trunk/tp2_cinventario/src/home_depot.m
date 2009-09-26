# Este es el "iwojima.m" de este tp jaja

global K; 

K = 0.0052;

global r;
function y = my_r(t)
    y = 100;
endfunction

r = 'my_r';

global u;
u = 'u_not_so_dummy';

j = 1;
s = '+o^*-';
#for K=0.001:.0509:1
k_plot.k_1.x = 0:5;

for K=logspace(0.001,.5,5)-1
    [t units sales_rate] = deposit_simulator(20000, 100, 4);
    k_plot = setfield(k_plot, sprintf('k_%d', j),'x',t);
    k_plot = setfield(k_plot, sprintf('k_%d', j),'y',units);
    label = sprintf("K = %g",K);
    k_plot = setfield(k_plot, sprintf('k_%d', j),'label',label);
    j++;
    hold on
endfor
poseplot(k_plot, 'k_plot.json');

hold off
