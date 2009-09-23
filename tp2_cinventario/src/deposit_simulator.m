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
    [t2, res] = ode45(@lsodee, linspace(0,trex,40), [initial_units, sales_rate], vopt);
    
    x1 = res(:,1);
    x2 = res(:,2);
    
endfunction 

