    format long;

	cantSimulations = 15;

	lambda = zeros(1,cantSimulations);
	mu = zeros(1,cantSimulations);
	meanQueueLength = zeros(1,cantSimulations);
	rhos = zeros(1,cantSimulations);
	theoreticalMeanQueueLength = zeros(1,cantSimulations);
	for i = 1 : cantSimulations
		%TODO ver que ondaaeE
		lambda(i) = 1.0;
		mu(i) = (i+1) / cantSimulations;
	endfor
	for i = 1 : cantSimulations
		[rho, meanQueueLength_i] = mm1(lambda(i),mu(i),100);

		% add the empirc mean value to the array ...
		meanQueueLength(i) = meanQueueLength_i;
		rhos(i) = rho;
		
		% calculate the theoretic mean time of arrivals ...
	%         f_lambda = 1.0/meanVals(1);
	%         f_mu = 1.0/meanVals(2);
	%         dW = 1.0/(f_mu - f_lambda);
	%         a_Lt(iCount) = f_lambda*dW;
		theoreticalMeanQueueLength(i) = rho/(mu(i) - lambda(i));
	endfor

    % Plot the results

    figure(1);

    plot(rhos,meanQueueLength);

    title(sprintf("Promedio temporal de clientes en cola en funcion de la intensidad de trafico"));
    xlabel(sprintf("clientes"));
    ylabel(sprintf("rho"));

    print -dpng queueVSrho.png 

    figure(2);

    plot (rhos,meanQueueLength,strcat("o;",sprintf("Promedio temporal empirico")),rhos, theoreticalMeanQueueLength, strcat("*;",sprintf("Promedio temporal teorico")));

    title (sprintf("Promedio temporal empirico y teorico en funcion de la intensidad de trafico"));
    xlabel (sprintf("clientes"));
    ylabel ("rho");

    print -dpng teorivoVSempirico.png

