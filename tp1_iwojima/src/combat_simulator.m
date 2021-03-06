#
# Combat simulator
# ----------------
#
# Se simula el combate de dos fuerzas antag�nicas que describen la
# siguiente ecuaci�n diferencial:
#
# xpunto1 (t) = -a * x1 (t) - c_21 * x2 (t) + r1(t)
#
# xpunto2 (t) = -b * x2 (t) - c_12 * x1 (t) + r2(t)
#
#
# Par�metros del sistema: a, b, c21 y c12
# Par�metros de la funci�n: r1 y r2, o sea la funci�n de refuerzo de los
# ejercitos en disputa.
#
function [t2 x1 x2] = combat_simulator(forces, trex, r1,r2)
    global a
    global b
    global c21
    global c12
    global R
    R = [r1;r2];

    vopt = odeset ("RelTol", 1e-3, "AbsTol", 1e-3, 
    "NormControl", "on",
        "MaxStep",1, "Events", @zero_crossing, "InitialStep", 1e-1);
    [t2, res] = ode45(@lsodee, linspace(0,trex,40), forces, vopt);
    
    x1 = res(:,1);
    x2 = res(:,2);
    
endfunction 

