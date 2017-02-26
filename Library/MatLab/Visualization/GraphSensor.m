function GraphSensor(Sensor, Box, Color)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GraphSensor -- Graph sensors.

[X,Y] = Split(Sensor);

if (nargin == 2)
  plot(X,Y, 'w*','MarkerSize',12)
else
  plot(X,Y, '*','MarkerSize',12, 'Color',Color)
end

Delta = [Box([2 4]) - Box([1 3])]/30;
N = size(Sensor,1);
for i = 1 : N
  text(X(i) + Delta, Y(i) + Delta, sprintf('%d', i));
end

axis(Box)