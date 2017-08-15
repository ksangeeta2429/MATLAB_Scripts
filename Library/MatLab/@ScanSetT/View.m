function View(Obj, Start, YRangeArg)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% View2d -- Look at the scans as a gray scale image

Esc = 27;

NumScan = Obj.NumScan;
Data = Obj.Data;

if nargin < 2
  ScanNum = 1;
  YRange = [min(min(Data)), max(max(Data))];
else    
  ScanNum = Start;
  if nargin <  3
    YRange = [min(min(Data)), max(max(Data))];
  else
    YRange = YRangeArg;
  end
end

%% Start Processing
Button = DisplayAndWait(Data(ScanNum,:), ScanNum,YRange);

while (Button ~= Esc)
  if (Button == 'u')
    if (1 < ScanNum)
      ScanNum = ScanNum - 1;
    else
      beep
    end
  else
    if (ScanNum < NumScan)
      ScanNum = ScanNum + 1;
    else
      beep
    end
  end
  
  Button = DisplayAndWait(Data(ScanNum,:), ScanNum,YRange);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Button = DisplayAndWait(Data, ScanNum,YRange)

plot(Data, 'Marker','.')

title(sprintf('Scan Num = %d', ScanNum));
axis([1,length(Data), YRange])

Type = waitforbuttonpress();
if (Type == 1)
  Button = get(gcf, 'CurrentCharacter');
else %% Still, not quite right ???
  Value = get(gcf, 'SelectionType');
  if Value(1) == 'n'
    Button = 'd';
  else
    Button = 'u';
  end
end