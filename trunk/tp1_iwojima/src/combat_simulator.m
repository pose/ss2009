#
# Combat simulator
# ----------------
#
# Se simula el combate de dos fuerzas antagónicas que describen la
# siguiente ecuación diferencial:
#
# xpunto1 (t) = -a * x1 (t) - c_21 * x2 (t) + r1(t)
#
# xpunto2 (t) = -b * x2 (t) - c_12 * x1 (t) + r2(t)
#
#
# Parámetros del sistema: a, b, c21 y c12
# Parámetros de la función: r1 y r2, o sea la función de refuerzo de los
# ejercitos en disputa.
#
function [t2 x1 x2] = combat_simulator(forces, time, r1,r2)
    global a
    global b
    global c21
    global c12
    global R
    R = [r1;r2];

    res = lsode("lsodee", forces, (t = linspace(0,time,1000))');
    
    t2 = t';
    x1 = res(:,1);
    x2 = res(:,2);
    
endfunction 

