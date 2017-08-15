function Result = Choose(M,N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Could improve, but works.

Num = 1;
for k = N - M + 1 : N
  Num = Num*k;
end

Denom = 1;
for k = 1 : M
  Denom = Denom*k;
end

Result = Num / Denom;