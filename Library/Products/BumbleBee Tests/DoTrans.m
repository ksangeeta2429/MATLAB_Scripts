function G = TransA(S)

R32 = 113e3;
C26 = 10e-9;
R33 = 73.2e3;
C25 = 2.2e-5;

Z0 = 1/(1/R32 + S*C26);
Z1 = R33 + 1/C35/S;

G = 1 + Z0/Z1;