# lsodee es la función que representa la ecuación diferencial que se
# va a integrar.
#
# X es el vector que contiene x1 y x2
# Xpunto es el vector que contiene xpunto1 y xpunto2
#
#   xpunto1 = u(t) - x_2(t)
#   xpunto2 = -K * u(t)
#
function Xpunto = lsodee(t, X)
    global u
    global K
    
    x1 = X(1); x2 = X(2);
    
    xpunto1 = feval(u,t) - x2;
    xpunto2 = -K * feval(u,t);
    
    Xpunto = [xpunto1 xpunto2];
endfunction 
