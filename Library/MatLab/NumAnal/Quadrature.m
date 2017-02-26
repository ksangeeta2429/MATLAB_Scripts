function Result = Quadrature(Integrand, InvMap, Eps)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Quadrature

H = 1;
[Odd,Even] = Sum(Integrand, H,Eps);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [OddSum,EvenSum] = Sum(Integrand,InvMap, Step,Eps);

OddSum = Integrand(0);

Count = 1;
ValLeft = Integrand(-Count

while max(abs(ValLeft)), abs(ValRight)) > Eps
  Count
end