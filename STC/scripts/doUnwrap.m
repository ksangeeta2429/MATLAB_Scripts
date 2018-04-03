% input: I, Q
% output: vector-Range
function [Range,Index]=doUnwrap(I,Q,sampRate)
C = 2.99792458e8;
lambda = C/5.8e9;

I(find(I>=4096)) = I(find(I>=4096)) - 4096;
Q(find(Q>=4096)) = Q(find(Q>=4096)) - 4096;

N = length(I);

% median_I = median(I)
% median_Q = median(Q)
Comp = (I - median(I)) + i*(Q - median(Q));

Range = lambda/2 * UnWrap(angle(Comp)/2/pi);    %, -0.5, 0.5
Index = ([1:N])/sampRate;
