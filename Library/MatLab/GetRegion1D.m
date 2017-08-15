function Lim = GetRegion(Data)
    
plot(Data)

N = length(Data);
Lim = [1, N];
Button = 0;

while Button ~= 27
  Range = Lim(2) - Lim(1);
  Low = round(Lim(1) - Range/2);
  High = round(Lim(2) + Range/2);
  
  Index = [max(1,Low) : min(High,N)];
  plot(Index, Data(Index));
  hold on
  
  Axis = axis;
  YRange = Axis(3:4);
  
  plot(repmat(Lim(1), 2,1), YRange', 'r', 'LineWidth',2);
  plot(repmat(Lim(2), 2,1), YRange', 'g', 'LineWidth',2);
  hold off
  
  axis([Low High YRange])
  
  [X,Trash,Button] = ginput(1);
  if Button == 1
    Lim(1) = X;
  elseif Button == 3
    Lim(2) = X;
  end
end

Region = Data(round(Lim(1)) : round(Lim(2)));
Lim(1) = round(Lim(1));
Lim(2) = round(Lim(2));
