function MarkRange(Range)

Axis = axis;
WasHold = ishold;

hold on
if size(Range,1) == 1
  plot(repmat(Range, 2,1), repmat(Axis(3:4)', 1,2), 'r', 'LineWidth',3);
else
  plot(repmat(Range', 2,1), repmat(Axis(3:4)', 1,2), 'r', 'LineWidth',3);
end

if ~WasHold
  hold off
end