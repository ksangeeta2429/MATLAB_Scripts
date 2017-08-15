function G = TransLpOld(S)

Cb = 16e-12;

R28 = 10e3;
C22 = 100e-9 + Cb;

% Z0 = 1 ./ C22*S;
% Z1 = R28;
% G = Z0 ./ (Z0 + Z1);

G = 1 ./ (1 + R28*C22*S);