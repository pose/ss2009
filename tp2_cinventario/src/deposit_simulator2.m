#
# Depot simulator
# ---------------
#
#
function [t2 x1 x2] = deposit_simulator(initial_units, sales_rate, trex)
    global u;
    global K;

    
    vopt = odeset ("RelTol", 1e-3, "AbsTol", 1e-3, "NormControl", "on",
        "MaxStep",1, "Events", @zero_crossing, "InitialStep", 1e-1);
#        "MaxStep",1, "InitialStep", 1e-1);
    [t2, res] = ode45(@other_lsodee, linspace(0,trex,60), [initial_units, sales_rate], vopt);
    
    x1 = res(:,1);
    x2 = res(:,2);
    
endfunction 


function Xpunto = other_lsodee(t, X)
    global u;
    global K;

    x1 = X(1); x2 = X(2);

    xpunto1 = feval(u,t,x1) - x2;
    xpunto2 = 6*x1 - K* feval(u,t,x1);

    Xpunto = [xpunto1 xpunto2];
endfunction
