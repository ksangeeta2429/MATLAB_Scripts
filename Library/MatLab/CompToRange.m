function Range = CompToRange(Comp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CompToRange -- Convert complex measurments into relitive range.

NumRow = size(Comp,1);

BumbleBee;

WrapPhase = atan2(imag(Comp), real(Comp));
WrapRot = WrapPhase / 2/pi;
WrapRange = WrapRot * (lambda/2);

for i = 1 : NumRow
  Range(i,:) = UnWrap(WrapRange(i,:), -lambda/4,lambda/4);
end