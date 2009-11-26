    format long;
    rand("seed",5);

	cantSimulations = 20;

	lambda = zeros(1,cantSimulations);
	mu = zeros(1,cantSimulations);
	meanQueueLength = zeros(1,cantSimulations);
	rhos = zeros(1,cantSimulations);
	theoreticalMeanQueueLength = zeros(1,cantSimulations);
	for i = 1 : cantSimulations
		%TODO ver que ondaaeE
        lambda(i) = 1.0;
        mu(i) = cantSimulations / i;
	endfor
	for i = 1 : cantSimulations
		[rho, relativeError, meanQueueLength_i] = mm1(lambda(i),mu(i),500);

		meanQueueLength(i) = meanQueueLength_i;
		rhos(i) = rho;
		
		theoreticalMeanQueueLength(i) = rho/(mu(i) - lambda(i));
	endfor

    % Plot the results

    figure(1);

    plot(rhos,meanQueueLength);

    title(sprintf("Promedio temporal de clientes en cola en funcion de la intensidad de trafico computado de manera empirica"));
    xlabel(sprintf("rho"));
    ylabel(sprintf("clientes"));

    print -dpng queueEmpiricVSrho.png 

    figure(2);

    plot(rhos,theoreticalMeanQueueLength);

    title(sprintf("Promedio temporal de clientes en cola en funcion de la intensidad de trafico computado de manera teorica"));
    xlabel(sprintf("rho"));
    ylabel(sprintf("clientes"));

    print -dpng queueTheoreticalVSrho.png 

    figure(3);

    plot(rhos,theoreticalMeanQueueLength,"-");
    hold on;
    plot(rhos,meanQueueLength,"-o");

    title (sprintf("Promedio temporal empirico y teorico en funcion de la intensidad de trafico"));
    xlabel (sprintf("rhos"));
    ylabel ("clientes");

    print -dpng teoricoVSempirico.png
    hold off;
