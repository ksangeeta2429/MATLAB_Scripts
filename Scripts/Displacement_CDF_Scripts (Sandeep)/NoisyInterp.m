function YEst = NoiseInterp(XData,YData, XVal)

%% less vectorized approach
for i = 1 : length(XVal)
  YList = AllCross(XData,YData, XVal(i));
  if isempty(YList)
    YEst(i) = NaN;
  elseif isscalar(YList)
    YEst(i) = YList;
  else
    YEst(i) = median(YList);
  end
end