function [Arg0,Arg1] = ReadComp(FileName)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ReadComp -- Read a data file that contains a compex sequence.

Data = ReadBin(FileName);
N = length(Data);

if ~(mod(N,2) == 0) % i.e., is odd
  WARNING('file appers inproperly truncated.')
  N = N - 1;
end

I = Data([1 : 2 : N-1]);
I = I - median(I);

Q = Data([2 : 2 : N]);
Q = Q - median(Q);

if nargout == 2
  Arg0 = I;
  Arg1 = Q;
elseif nargout == 1
  Arg0 = I + i*Q;
end