function Mask = DispDet(Comp, M,Thresh)

N = length(Comp);
L = N - M + 1;

RunIndex = 1 + repmat([0:M-1], L,1) + repmat([0 : L-1]', 1,M);

Rot = UnWrap(angle(Comp)/2/pi);
RunRot = Rot(RunIndex);

Min = min(RunRot,[], 2);
Max = max(RunRot,[], 2);
Range = Max - Min;

Start = (Thresh < Range);

Mask = zeros(1,N);
Mask(RunIndex(Start,:)) = 1;