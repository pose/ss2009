format long

global a
global b
global c21
global c12

# Item a)
# Despreciando las tasas unitarias de perdidas operativas:
a = 0; b = 0;


# demostrar que existe una constante K tal que:
#
#  c21 x^2 - c12 y^2 = K
#


c12 = .0544;
c21 = .0106;

[t x1 x2] = combat_simulator([21500,0], 36.4, "zeroreinforcement", "reinforcement");

res = [t, x1, x2]
