function [Tau,F] = CompTau(R,C)

Tau = R*C;
Omega = 1/Tau;
F = Omega/2/pi;