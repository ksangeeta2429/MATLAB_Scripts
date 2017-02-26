function [R,I] = SimulUnToReIm(SimulUn)

N = length(SimulUn);
if (mod(N,3) ~= 0)
  error('Data did not end of a boundary');
end

R = SimulUn([1 : 3 : N]);
I = SimulUn([2 : 3 : N]);