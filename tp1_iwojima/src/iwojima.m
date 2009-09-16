format long

global a
global b
global c21
global c12

# Despreciamos las tasas unitarias de perdidas operativas:
a = 0; b = 0;

# Coeficientes de efectividad en combate de la fuerza enemiga
c12 = .0544;    # "Daño efectivo" que le hace la fuerza 1 a la fuerza 2
c21 = .0106;    # "Daño efectivo" que le hace la fuerza 2 a la fuerza 1

# Fuerza 1: Japón
# Fuerza 2: EEUU

days = 36; #duración en días de la batalla

[t x1 x2] = combat_simulator(
        [21500,0],              #Cantidad de fuerzas en combate: ej: [japon usa]
        days,                    
        "zeroreinforcement",    #política de refuerzos de la primera fuerza
        "reinforcement");       #política de refuerzos de la segunda fuerza

res = [t,                       #días simulados
        x1,                     #cantidad de tropas primera fuerza
        x2];                     #cantidad de tropas segunda fuerza

japan_vs_usa.t = t;
japan_vs_usa.japan = x1;
japan_vs_usa.usa = x2;

global last_figure;
last_figure = 0;

function n=next_figure()
    global last_figure;
    n=++last_figure;
    figure(n);
endfunction

# --------------------------------------------------
# --------------------------------------------------
#                       Punto (a)
# --------------------------------------------------
# --------------------------------------------------
#
# (incluir mi ecuación)
# El valor de K, como se puede observar es una constante de integración. 
# Depende de las condiciones iniciales, en este caso particular es la diferencia
# de tropas entre una fuerza y otra.
#
#
# Dejamos y en función de x:
#
# alpha * y^2 - beta * x^2 = K
#
# y^2 = (K + beta * x^2) / alpha
#
# y = sqrt( K + beta * x^2 ) / alpha
#

#alpha = 0.01;
#beta = 0.04;
#K = [0,5000,10000,-10000,-5000];
#s = '-+^*ox';

function draw_k(x, alpha, beta, K, s)
    
    for i=1:length(K)
        if K(i) != 0
            y = real(sqrt((K(i) + beta * x.*x) / alpha ));
        else
            y = real(sqrt(beta/alpha) * x);
        endif
        plot (x, y, sprintf('%c;K = %d;',s(i),K(i)));
        hold on
    endfor

    legend({},"location","southeast")
    legend("boxon")
    hold off


    xlabel (sprintf("{/Helvetica}Efectivos de (1) \n {/Symbol a } = %g",alpha));
    ylabel (sprintf("{/Helvetica}Efectivos de (2) \n {/Symbol b } = %g",beta));
    t = title (['{/Helvetica}Efectos de la variaci',243,'n de K']);

    grid("on");

endfunction

next_figure();
draw_k(linspace(0,2500,50),0.01, 0.04, [0,10000,20000,-10000,-20000], '-+^*ox');
print -dpng power_areas_1.png 
next_figure();
draw_k(linspace(0,2500,50),0.01, 0.01, [0,10000,20000,-20000,-10000], '-+^*ox');
print -dpng power_areas_2.png 
next_figure();
draw_k(logspace(0,3.85,25),0.01, 0.04, [0,25000,50000,-50000,-25000], '-+^*ox');
print -dpng power_areas_1b.png 
next_figure();
draw_k(logspace(0,3.85,25),0.01, 0.01, [0,25000,50000,-50000,-25000], '-+^*ox');
print -dpng power_areas_2b.png 



# --------------------------------------------------
# --------------------------------------------------
#                       Punto (b)
# --------------------------------------------------
# --------------------------------------------------

# --------------------------------------------------
# Gráfico de x(t) e y(t) versus t
# --------------------------------------------------
next_figure();

plot (japan_vs_usa.t, japan_vs_usa.japan,strcat("o;Fuerzas del Imperio del Jap",sprintf("%c",243),"n;"), japan_vs_usa.t, japan_vs_usa.usa,strcat("*;Fuerzas de Estados Unidos;"));
title (strcat("Simulaci",sprintf("%c",243),"n num",sprintf("%c",233),"rica de la batalla de Iwo Jima"));

xlabel (strcat("Tiempo (d",sprintf("%c",237),"as)"));
ylabel ("Cantidad de tropas");

grid("on");

print -dpng jap_vs_usa.png 

# --------------------------------------------------
# Gráfico de fuerzas norteamericanas reales contra simuladas
# --------------------------------------------------
next_figure();

plot(japan_vs_usa.t, japan_vs_usa.usa,"*;Unidades simuladas;",[7,9,12,19,24],[66000, 62000, 58500, 56200, 54000],strcat("+;Unidades hist",sprintf("%c",243),"ricas;"),"markersize",10);

title (strcat("Comparaci",sprintf("%c",243),"n de datos hist",sprintf("%c",243),"ricos contra datos simulados (Estados Unidos)"));

xlabel (strcat("Tiempo (d",sprintf("%c",237),"as)"));
ylabel ("Cantidad de tropas");

grid("on");

print -dpng  real_vs_sim.png

# Duración de la batalla: Poner que si bien idealmente sería hasta que la 
# fuerza enemiga sea 0 habría que tener en cuenta también en la organización
# militar hay ciertos mínimos a partir de los cuales no se puede luchar más,
# tanto por deserciones, propaganda, etc. 
#
# Quizás podés mecharlo con esto:
# http://es.wikipedia.org/wiki/Unidad_militar


# --------------------------------------------------
# --------------------------------------------------
#                       Punto (c)
# --------------------------------------------------
# --------------------------------------------------

# --------------------------------------------------
# Política con reinforcement (2)
# --------------------------------------------------

[t x1 x2] = combat_simulator(
        [21500,0],              #Cantidad de fuerzas en combate: ej: [japon usa]
        70,             
        "zeroreinforcement",    #política de refuerzos de la primera fuerza
        "reinforcement2");       #política de refuerzos de la segunda fuerza

reinforce2.t = t;
reinforce2.japan = x1;
reinforce2.usa = x2;

next_figure();

plot (reinforce2.t, reinforce2.japan,strcat("o;Fuerzas del Imperio del Jap",sprintf("%c",243),"n;"), reinforce2.t, reinforce2.usa,"*;Fuerzas de Estados Unidos;");
title (strcat("Pol",sprintf("%c",237),"tica de refuerzo alternativa (I) para el ej",sprintf("%c",233),"rcito de Estados Unidos"));

xlabel (strcat("Tiempo (d",sprintf("%c",237),"as)"));
ylabel ("Cantidad de tropas");

grid("on");

print -dpng reinforce2.png 

# --------------------------------------------------
# Política con reinforcement (3)
# --------------------------------------------------

[t x1 x2] = combat_simulator(
        [21500,0],              #Cantidad de fuerzas en combate: ej: [japon usa]
        16,             
        "zeroreinforcement",    #política de refuerzos de la primera fuerza
        "reinforcement3");       #política de refuerzos de la segunda fuerza

reinforce3.t = t;
reinforce3.japan = x1;
reinforce3.usa = x2;

next_figure();

plot (reinforce3.t, reinforce3.japan, strcat("o;Fuerzas del Imperio del Jap",sprintf("%c",243),"n;"), reinforce3.t, reinforce3.usa,"*;Fuerzas de Estados Unidos;");
title (strcat("Pol",sprintf("%c",237),"tica de refuerzo alternativa (II) para el ej",sprintf("%c",233),"rcito de Estados Unidos"));

xlabel (strcat("Tiempo (d",sprintf("%c",237),"as)"));
ylabel ("Cantidad de tropas");

grid("on");

print -dpng reinforce3.png


# --------------------------------------------------
# Política con reinforcement (4)
# --------------------------------------------------

[t x1 x2] = combat_simulator(
        [21500,0],              #Cantidad de fuerzas en combate: ej: [japon usa]
        36,             
        "zeroreinforcement",    #política de refuerzos de la primera fuerza
        "reinforcement4");       #política de refuerzos de la segunda fuerza

reinforce4.t = t;
reinforce4.japan = x1;
reinforce4.usa = x2;

next_figure();

plot (reinforce4.t, reinforce4.japan, strcat("o;Fuerzas del Imperio del Jap",sprintf("%c",243),"n;"), reinforce4.t, reinforce4.usa,"*;Fuerzas de Estados Unidos;");
title (strcat("Pol",sprintf("%c",237),"tica de refuerzo alternativa (III) para el ej",sprintf("%c",233),"rcito de Estados Unidos"));

xlabel (strcat("Tiempo (d",sprintf("%c",237),"as)"));
ylabel ("Cantidad de tropas");

grid("on");

print -dpng reinforce4.png
