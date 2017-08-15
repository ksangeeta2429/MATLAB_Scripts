function SplitFiles(Path, Direction, Mask)

FileList = dir(sprintf('%s/%s', Path,Mask));

for File = { FileList.name }
  FullName = sprintf('%s/%s', Path,File{1});
  Comp = ReadComp(FullName);

  Rot = UnWrap(angle(Comp)/2/pi);
  Done = false;
  
  while ~Done
    Lim = GetRegion(Rot);
    Index = [Lim(1) : Lim(2)];
  
    RunNum = input('Enter run num: ');
    if isempty(RunNum)
      Done = true;
    else
      OutName = sprintf('%s/Walk_%s_%d.data', Path,Direction,RunNum);
      WriteComp(OutName, Comp(Index));
    end
  end
end