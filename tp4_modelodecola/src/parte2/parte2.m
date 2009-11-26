    format long;
    rand("seed",9);

	cantSimulations = 15;

	lambda = zeros(1,cantSimulations);
	mu = zeros(1,cantSimulations);
	meanQueueWait = zeros(1,cantSimulations);
	rhos = zeros(1,cantSimulations);
	theoreticalMeanQueueWait = zeros(1,cantSimulations);
	for i = 1 : cantSimulations
          lambda(i) = 1.0;
          mu(i) = cantSimulations / i;
	endfor
	for i = 1 : cantSimulations
	  [rho, relativeError, meanQueueWait_i] = mm1(lambda(i),mu(i),100);
	  meanQueueWait(i) = meanQueueWait_i;
	  rhos(i) = rho;
	  theoreticalMeanQueueWait(i) = rho/(mu(i) - lambda(i));
	endfor

    % Plot the results

    figure(1);
 
    plot(rhos,meanQueueWait,"+");

    title(sprintf("Tiempo medio de espera en cola por cliente \ncomputado de manera empirica"));
    xlabel(sprintf("rho"));
    ylabel(sprintf("unidades de tiempo"));

    print -dpng queueWaitEmpirical.png 

    figure(2);

    plot(rhos,theoreticalMeanQueueWait, "o");

    title(sprintf("Tiempo medio de espera en cola por cliente \ncomputado de manera teorica"));
    xlabel(sprintf("rho"));
    ylabel(sprintf("unidades de tiempo"));

    print -dpng queueWaitTheoretical.png 

    figure(3);

    plot(rhos,theoreticalMeanQueueWait,"-o;Teorico;");
    hold on;
    plot(rhos,meanQueueWait,"+;Empirico;");

    %title (sprintf("Tiempo medio de espera por cliente empirico y teorico\n en funcion de la intensidad de trafico"));
    xlabel (sprintf("rho"));
    ylabel ("unidades de tiempo");

    print -dpng queueWaitCompare.png
    hold off;
