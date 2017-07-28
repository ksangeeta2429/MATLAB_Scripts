function FeatSet = RangeSlice(Path,Mask, MinDist,RangeSet, M,N)

%% Assign constants
Mid = (N + 1)/2;

BumbleBee;

%% Do Compuation
FileList = dir(sprintf('%s/%s', Path,Mask));
if isempty(FileList)
  ERROR('no files')
else
  NumFile = length(FileList);
end

for i = 1 : NumFile
  Name = FileList(i).name;
  FullName = sprintf('%s/%s', Path,Name);

  Comp = ReadComp(FullName);
  NumSamp = length(Comp);

  Rot = UnWrap(angle(Comp)/2/pi);
  Index = [Mid : NumSamp - Mid + 1];
  Dist = (Rot(Index) - min(Rot))*lambda/2 + MinDist;

  Feat = MofN(abs(Comp), M,N);

  FeatSet(:,i) = NoisyInterp(Dist,Feat, RangeSet);
end