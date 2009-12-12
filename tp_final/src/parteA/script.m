load arriboscop.mat
load ercop.mat

rand("seed",234234);

%%%%%%%%%%%HISTOGRAMAS
figure(1);
%clases=12;
[expfrecs expmarks]=hist(arriboscop,12);
hist(arriboscop,12);
xlabel("Intervalos de clase");
ylabel("Cantidad de arribos");
title("Histograma del tiempo entre arribo de unidades");
print -deps hist_arribos.eps 

figure(2); 
ercopdata=unfrec(ercop(:,2)',ercop(:,1)',38)
ercop(:,1)'
[erfrecs ermarks]=hist(ercopdata,ercop(:,1)')
hist(ercopdata,ercop(:,1)');
xlabel("Intervalos de clase");
ylabel("Frecuencia");
title("Histograma del tiempo de atencion de unidades");
print -deps hist_servicios.eps 


%%%%%%%%%%%TESTS
%EXPONENCIAL
ideal_set = [];
for i=1:columns(arriboscop)
  ideal_set=[ideal_set expon(mean(arriboscop))];
endfor

[pval, chisq, df] = chisquare_test_homogeneity(arriboscop,ideal_set,expmarks);
printf('nivel de significacion de la exponencial: %f\n', pval);

%TRIANGULAR
a=0;
b=1.25;
c=1.81;

ideal_set=[];
magic_number=1000;
%*(10/(c-a))
for i=1:sum(erfrecs)*magic_number
    ideal_set = [ideal_set randtriang(a,b,c)];
endfor

%ercopdata
%unfrec(chi_test,ermarks,columns(ercopdata))
empirical_set=unfrec(erfrecs.*magic_number,ermarks,sum(erfrecs)*magic_number);

figure(3);
hist(ideal_set,ermarks);
figure(4);
hist(empirical_set, ermarks);

[pval, chisq, df] = chisquare_test_homogeneity(ideal_set,empirical_set,ermarks);
printf('nivel de significacion de la exponencial: %f\n', pval);
pval
chisq
df
