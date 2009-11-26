    format long;
    rand("seed",9);

	cantSimulations = 10;

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
	  [rho, relativeError, meanQueueWait_i] = mm1(lambda(i),mu(i),500);
	  meanQueueWait(i) = meanQueueWait_i;
	  rhos(i) = rho;
	  theoreticalMeanQueueTime(i) = rho/(mu(i) - lambda(i));
	endfor

    % Plot the results

    figure(1);
 
    plot(rhos,meanQueueWait);

    title(sprintf("Tiempo medio de espera en cola por cliente computado de manera empirica"));
    xlabel(sprintf("rho"));
    ylabel(sprintf("clientes"));

    print -dpng queueWaitEmpirical.png 

    figure(2);

    plot(rhos,theoreticalMeanQueueWait);

    title(sprintf("Tiempo medio de espera en cola por cliente computado de manera teorica"));
    xlabel(sprintf("rho"));
    ylabel(sprintf("clientes"));

    print -dpng queueWaitTheoretical.png 

    figure(3);

    plot(rhos,theoreticalMeanQueueWait,"-");
    hold on;
    plot(rhos,meanQueueWait,"-o");

    title (sprintf("Tiempo medio de espera por cliente empirico y teorico en funcion de la intensidad de trafico"));
    xlabel (sprintf("rhos"));
    ylabel ("clientes");

    print -dpng queueWaitCompare.png
    hold off;
