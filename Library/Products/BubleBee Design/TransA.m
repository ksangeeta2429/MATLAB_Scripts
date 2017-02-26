function G = TransA(S)

Cb = 16e-12;

R33 = 73.2e3;
C25 = 2.2e-6 + Cb;

R32 = 1.40e6;
% C26 = 820e-12 + Cb;
C26 = 920e-12 + Cb;

Z0 = 1 ./ (1/R32 + S *C26);
Z1 = R33 + 1/C25 ./ S;

G = 1 + Z0 ./ Z1;