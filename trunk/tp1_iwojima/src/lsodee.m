# lsodee es la función que representa la ecuación diferencial que se
# va a integrar.
#
# X es el vector que contiene x1 y x2
# Xpunto es el vector que contiene xpunto1 y xpunto2
#
function Xpunto = lsodee(X, t)
    global a
    global b
    global c21
    global c12
    global R
    x1 = X(1); x2 = X(2);
    r1 = R(1,:); 
    r2 = R(2,:);
    r1res = feval(strtrim(r1), t);
    r2res = feval(strtrim(r2), t);
    xpunto1 = -a * x1 - c21 * x2 + r1res;
    xpunto2 = -b * x2 - c12 * x1 + r2res;
    Xpunto = [xpunto1 xpunto2];
endfunction 
