function [R,I] = SimulToReIm(Simul)

N = length(Simul);
if (mod(N,2) ~= 0)
  error('Data did not end of a boundary');
end

R = Simul([1 : 2 : N]);
I = Simul([2 : 2 : N]);