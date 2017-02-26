function MadeFig = FixLostByte(InFile,OutFile, Rate)

%% Read bytes
InByte = ReadRaw(InFile, 'uint8');
N = length(InByte);

%% Build OutBytes.  Don't see way to vecterize without a new primitive
Start = 1;
OutByte = [];
NumDrop = 0;

BadOffSet = find(16 <= InByte(Start + 1 : 2 : N), 1);

while ~isempty(BadOffSet)
  NumDrop = NumDrop + 1;

  BadPos = 2*BadOffSet + Start - 1;
  OutByte = [OutByte; InByte(Start : BadPos - 2)];
  
  Start = BadPos;
  BadOffSet = find(16 <= InByte(Start + 1 : 2 : N), 1);
end

TailDrop = mod(length(OutByte) + N - Start + 1, 4);
OutByte = [OutByte; InByte(Start : N - TailDrop)];

fprintf('Drop = %d', NumDrop);

%% Write output
assert(mod(length(OutByte),4) == 0);
WriteRaw(OutFile, OutByte, 'uint8');

%% May be a better way ???
if nargout > 0
  MadeFig = false;
end