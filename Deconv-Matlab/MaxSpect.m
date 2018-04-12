function MaxSpect(Comp, FullScale)

N = length(Comp);
Rate = 1024/3;

% Graph Spect
if nargin == 2
  [C,F,T] = MySpect(Comp, FullScale);
else
  [C,F,T] = MySpect(Comp);
end
hold on

% Graph Max
[Trash,Index] = max(abs(C),[], 2);

Vol = F(Index);

% plot(Vol,T, 'b', 'LineWidth',2);
plot(Vol,T, 'b', 'LineWidth',2);
hold off

legend('Max', 'location', 'NorthWest');