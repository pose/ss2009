    format long;
    rand("seed",5);

	cantSimulations = 3;

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
		[rho, relativeError, meanQueueLength_i] = mm1(lambda(i),mu(i),100);

        relativeError(end)

		% add the empirc mean value to the array ...
		meanQueueLength(i) = meanQueueLength_i;
		rhos(i) = rho;
		
		theoreticalMeanQueueLength(i) = rho/(mu(i) - lambda(i));
	endfor

    % Plot the results

    figure(1);

    plot(rhos,meanQueueLength);

    title(sprintf("Promedio temporal de clientes en cola en funcion de la intensidad de trafico"));
    xlabel(sprintf("rho"));
    ylabel(sprintf("clientes"));

    print -dpng queueVSrho.png 

    figure(2);

    plot(rhos,theoreticalMeanQueueLength,"o;Promedio temporal teorico",rhos,meanQueueLength , "*;Promedio temporal empirico");

    title (sprintf("Promedio temporal empirico y teorico en funcion de la intensidad de trafico"));
    xlabel (sprintf("rhos"));
    ylabel ("clientes");

    print -dpng teorivoVSempirico.png

