function [delay delay_error ss ss_error ql ql_error] = STStressTest_helper(p,max_time)

[means(1) delays{1} ss{1} ql{1} xx yy] = simulate(p, max_time);
for i = 2:10
	[just_mean(i) just_delay{i} just_ss{i} just_ql{i} xx yy] = simulate(p, max_time);
	means(i) = (means(i-1) * (i-1) + just_mean(i) ) / i;
	
	delays = process_data(delays,just_delay,i);
	ss = process_data(ss,just_ss,i);
	ql = process_data(ql,just_ql,i);
end


alpha = .05;

semi_delay = semi_amplitude(just_delay,alpha);
semi_ss = semi_amplitude(just_ss,alpha);
semi_ql = semi_amplitude(just_ql,alpha);

delay = [delays{i}(1) delays{i}(2) delays{i}(3)];
delay_error = [semi_delay(1) semi_delay(2) semi_delay(3)];

ss = [ ss{i}(2) ss{i}(3) ss{i}(4)];
ss_error = [semi_ss(2) semi_ss(3) semi_ss(4)]; 

ql = [ql{i}(1) ql{i}(2) ql{i}(3)];
ql_error = [semi_ql(1) semi_ql(2) semi_ql(3)];

%fprintf(stdout, 'Tiempo promedio en cola UI: %g +/- %g minutos\n', delays{i}(1), semi_delay(1));
%fprintf(stdout, 'Tiempo promedio en cola ER: %g +/- %g minutos\n', delays{i}(2), semi_delay(2));
%fprintf(stdout, 'Tiempo promedio en cola ST: %g +/- %g minutos\n', delays{i}(3), semi_delay(3));

%fprintf(stdout, 'Longitud media de la cola UI: %g +/- %g minutos\n', ql{i}(1), semi_ql(1));
%fprintf(stdout, 'Longitud media de la cola ER: %g +/- %g minutos\n', ql{i}(2), semi_ql(2));
%fprintf(stdout, 'Longitud media de la cola ST: %g +/- %g minutos\n', ql{i}(3), semi_ql(3));

%fprintf(stdout, 'Ocupacion del servidor ER1: %g +/- %g minutos\n', ss{i}(2), semi_ss(2));
%fprintf(stdout, 'Ocupacion del servidor ER2: %g +/- %g minutos\n', ss{i}(3), semi_ss(3));
%fprintf(stdout, 'Ocupacion del servidor ER3: %g +/- %g minutos\n', ss{i}(4), semi_ss(4));

end

