function A_01=MatrixThrRelative(A,thrFactor)

thr=max(max(A))*thrFactor;
A_01=A>=thr;