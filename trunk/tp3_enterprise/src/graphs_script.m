
global last_figure;
last_figure = 0;

function n=next_figure()
    global last_figure;
    n=++last_figure;
    figure(n);
endfunction

#seeds for lecuyer
seed1=1;
seed2=1;
nums = lecuyer(seed1,seed2,10000);

#histograma de ecuyer

next_figure();

title(sprintf("Distribucion muestral"));

hist(nums);

title(sprintf("Distribucion muestral uniforme"));

xlabel(sprintf("Clase [n]"));
ylabel(sprintf("Frecuencia [n]"));

print -dpng histograma_ecuyer.png

#Hacemos esto para que se vea mejor
nums = lecuyer(seed1,seed2,2000);

#graphic of xn versus xn+1

next_figure();

xs=nums(1:(columns(nums)-1));
ys=nums(2:columns(nums));

plot(xs,ys,'*');

title(sprintf("xn versus xn+1"));
xlabel(sprintf("xn"));
ylabel(sprintf("xn+1"));

print -dpng ecuyer2D.png 

#triangular

next_figure();

x_triangle = [0:.1:3];
for i=1:columns(x_triangle)
    y_triangle(i) = triangle(x_triangle(i),0,1,3);
endfor

plot(x_triangle,y_triangle);

title(sprintf("Funcion triangular"));

xlabel(sprintf("x"));
ylabel(sprintf("f(x)"));

print -dpng triangular.png

#Histograma de la triangular

next_figure();

hist(mi_randtraing(lecuyer(3111,53363,10000),0,1,3));

title(sprintf("Distribucion muestral triangular"));

xlabel(sprintf("Clase [n]"));
ylabel(sprintf("Frecuencia [n]"));

print -dpng histograma_triangular.png

#3d plotting

xs=nums(1:(columns(nums)-2));
ys=nums(2:columns(nums)-1);
zs=nums(3:columns(nums));

next_figure();
plot3(xs,ys,zs,'*');

title(sprintf("xn versus xn+1 versus xn+2"));
xlabel (sprintf("xn"));
ylabel (sprintf("xn+1"));
zlabel (sprintf("xn+2"));

print -dpng ecuyer3D_1.png 

next_figure();

#3d plotting with rotation
[xs2 ys2 zs2] = seba_rotation(xs,ys,zs,0,0,pi/2);
#figure(3);
plot3(xs2,ys2,zs2,'*');

title(sprintf("xn versus xn+1 versus xn+2 rotado en z 90 grados"));
xlabel (sprintf("xn"));
ylabel (sprintf("xn+1"));
zlabel (sprintf("xn+2"));

print -dpng ecuyer3D_z90.png 

#3d plotting with rotation
[xs2 ys2 zs2] = seba_rotation(xs,ys,zs,0,pi/2,0);
#figure(3);
plot3(xs2,ys2,zs2,'*');

title(sprintf("xn versus xn+1 versus xn+2 rotado en y 90 grados"));
xlabel (sprintf("xn"));
ylabel (sprintf("xn+1"));
zlabel (sprintf("xn+2"));

print -dpng ecuyer3D_y90.png 

#3d plotting with rotation
[xs2 ys2 zs2] = seba_rotation(xs,ys,zs,pi/2,0,0);
#figure(3);
plot3(xs2,ys2,zs2,'*');

title(sprintf("xn versus xn+1 versus xn+2 rotado en x 90 grados"));
xlabel (sprintf("xn"));
ylabel (sprintf("xn+1"));
zlabel (sprintf("xn+2"));

print -dpng ecuyer3D_x90.png 


next_figure();
points=56;
[means desv err] = avgtime([1:points]);
plot([1:points],means);
title(sprintf("Integral estimada"));
xlabel(sprintf("Numero de simulaciones"));
ylabel(sprintf("Tiempo de operacion [hs]"));

print -dpng mean.png

next_figure();
plot([1:points],err.*100);
title(sprintf("Error de estimacion"));
xlabel(sprintf("Numero de simulaciones"));
ylabel(sprintf("Error relativo porcentual"));

print -dpng desv.png


