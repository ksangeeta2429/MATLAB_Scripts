function Box = InputReg2(X,Y, ImageData)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% InputReg2 -- interactivly input a reion in an image.

[XSize,YSize] = size(ImageData);
ColorDepth = 256;

LowX = 1;
HighX = XSize;
LowY = 1;
HighY = YSize;

Button = 0;

while Button ~= 27
  Width = HighX - LowX;
  Height = HighY - LowY;

  LowGraphX = round(LowX - Width/2);
  HighGraphX = round(HighX + Width/2);
  LowGraphY = round(LowX - Width/2);
  HighGraphY = round(HighX + Width/2);

  %% Display subset of the image
  XIndex = [max(1,LowGraphX) : min(HighGraphY,XSize)];
  YIndex = [max(1,LowGraphY) : min(HighGraphY,YSize)];
  
  Index = MakeGrid(YIndex,XIndex, XSize); %% backwards, need to fix
%%  Index = MakeGrid(XIndex,YIndex, XSize); %% correct
  
  image( ...
    X(XIndex), Y(YIndex), ...
    AutoScaleInt(ImageData(Index), 0,ColorDepth - 1));
  colormap(jet(ColorDepth))
  hold on

  plot([LowX LowX], Y([LowGraphY HighGraphY]), 'r', 'LineWidth',2);
  plot(X([LowGraphX HighGraphX]), [HighY HighY], 'r', 'LineWidth',2);
  plot([HighX HighX], Y([LowGraphY HighGraphY]), 'g', 'LineWidth',2);
  plot(X([LowGraphX HighGraphX]), [LowY LowY], 'g', 'LineWidth',2);
  hold off

  axis([LowGraphX HighGraphX LowGraphY HighGraphY])

  [XCoord,YCoord,Button] = ginput(1);
  XLoc = interp1(XIndex,X, XCoord);
  YLoc = interp1(YIndex,Y, YCoord);
  
  if Button == 1 %% Upper left cornor
    LowX = XLoc;
    HighY = YLoc;
  elseif Button == 3 %% Lower right cornor
    HighX = XLoc;
    LowY = YLoc;
  end
end

Box = [LowX,HighX,LowY,HighY];