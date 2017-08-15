function [X,Y,T] = MakeLine(XRange,YRange,N);

T = [0 : N-1]/(N-1);
X = T*(XRange(2) - XRange(1)) + XRange(1);
Y = T*(YRange(2) - YRange(1)) + YRange(1);