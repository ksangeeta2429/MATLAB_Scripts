function Index = RandReplace(SetSize, N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RandReplace -- Picks N random elements from a set, with replacement

if N < 1
  Index = [];
else
  Index = floor(rand(1,N) * SetSize) + 1;
end