function parte1()

	rho = 0.0;

	cantSimulations = 100;

	lambda = zeros(1,cantSimulations);
	mu = zeros(1,cantSimulations);
	meanQueueLength = zeros(1,cantSimulations);
	rhos = zeros(1,cantSimulations);
	theoreticalMeanQueueLength = zeros(1,cantSimulations);

	for i = 1 : cantSimulations
		%TODO ver que ondaaeE
		lambda(j) = 1.0;
		mu(j) = (j+1) / i;
	endfor

	for i = 1 : cantSimulations
		
		meanVals(1) = a_means(i);
		meanVals(2) = a_means(i+1);
		[rho, meanQueueLength_i] = mm1(lambda(i),mu(i),100);
		

		% add the empirc mean value to the array ...
		meanQueueLength(i) = meanQueueLength_i;
		rhos(i) = rho;
		
		% calculate the theoretic mean time of arrivals ...
	%         f_lambda = 1.0/meanVals(1);
	%         f_mu = 1.0/meanVals(2);
	%         dW = 1.0/(f_mu - f_lambda);
	%         a_Lt(iCount) = f_lambda*dW;
		theoreticalMeanQueueLength(i) = rho/(1.0 - rho);
	endfor

endfunction