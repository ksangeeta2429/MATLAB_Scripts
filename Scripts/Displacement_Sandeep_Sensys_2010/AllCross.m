function YList = AllCross(XData,YData, X)

Cross = find(diff(XData < X) ~= 0);

if isempty(Cross)
  YList = [];
else
  for i = 1 : length(Cross)
    Seg = Cross(i) + [0 1];
    YList(i) = interp1(XData(Seg), YData(Seg), X);
  end
end