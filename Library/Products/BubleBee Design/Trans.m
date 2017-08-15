function Result = Trans(Omega, ZeroList,PoleList)

Result = 1;

for Z = ZeroList
  Result = Result*(Omega*i - Z);
end

for P = PoleList
  Result = Result/(Omega*i - P);
end