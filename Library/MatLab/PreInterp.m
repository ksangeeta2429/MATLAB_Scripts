function [XOut,YOut] = PreInterp(X,Y)

N = length(Y);

Start = 1;
End = Start + 1;
OutLen = 0;

while (Start < N)
  Pos = X(Start);
  
  while ((End < N) & (X(End) == Pos))
    End = End + 1;
  end

  OutLen = OutLen + 1;
  XOut(OutLen) = Pos;
  YOut(OutLen) = mean(Y(Start : End - 1));
  
  Start = End;
  End = End + 1;
end