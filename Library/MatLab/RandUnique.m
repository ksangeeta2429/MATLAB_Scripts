function Index = RandUnique(SetSize, N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RandUnigue -- Pick N unique random elements from a set.

if N < 1
  Index = [];
else
  Set = [1 : SetSize];
  for i = 1 : N
    M = SetSize - i + 1;
    Pick = floor(rand(1,1) * M) + 1;
    Index(i) = Set(Pick);
    Set = [Set(1 : Pick - 1), Set(Pick + 1 : M)];
  end
end