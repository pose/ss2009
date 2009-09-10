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


# --------------------------------------------------
# Gráfico de x(t) e y(t) versus t
# --------------------------------------------------
figure(1);

plot (t, x1,strcat(";Fuerzas del Imperio del Jap",sprintf("%c",243),"n;"), t, x2,strcat("*;Fuerzas de Estados Unidos;"));
title (strcat("Simulaci",sprintf("%c",243),"n num",sprintf("%c",233),"rica de la batalla de Iwo Jima"));

xlabel (strcat("Tiempo (d",sprintf("%c",237),"as)"));
ylabel ("Cantidad de tropas");

grid("on");


# --------------------------------------------------
# Gráfico de fuerzas norteamericanas reales contra simuladas
# --------------------------------------------------
figure(2);

other_t = linspace(1,days,40);
plot(t, x2,"-;Unidades simuladas;",other_t,american(other_t)',"+;Unidades reales;","markersize",10);
title (strcat("Comparaci",sprintf("%c",243),"n de fuerzas reales contra simuladas en la batalla de Iwo Jima"));

xlabel (strcat("Tiempo (d",sprintf("%c",237),"as)"));
ylabel ("Cantidad de tropas");

grid("on");
