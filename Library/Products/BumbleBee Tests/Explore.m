function Explore(Comp,Rate)

N = length(Comp);
Time = [0 : N-1]/Rate;

%% Graph Amp
subplot(3,1,1)

GraphAmp(Time,Comp,Rate);

%% Make push button
uicontrol(...
  'Style','PushButton', 'CallBack',@GraphPhase, ...
  'BackgroundColor',[1 0 1], 'String','Sync', ...
  'UserData', Comp)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function GraphPhase(Obj, Event)

%% Stuff that should be in the object
Rate = 250;

%% Get Data
Comp = get(Obj,'UserData');
N = length(Comp);

Time = [0 : N-1] / Rate;

%% Get region
subplot(3,1,1);
Axis = axis;
Mask = (Axis(1) <= Time) & (Time <= Axis(2));
Index = find(Mask);

%% Graph raw phase
subplot(3,1,2)

UnRot = UnWrap(angle(Comp(Index))/2/pi, -0.5,0.5);
plot(Time(Index),UnRot);

axis tight
ylabel('Rotations');

%% Graph Algo
subplot(3,1,3)

Mean = median(abs(Comp(Index)));

Metric = abs(Comp(Index))/Mean;
plot(Time(Index),Metric, '.')