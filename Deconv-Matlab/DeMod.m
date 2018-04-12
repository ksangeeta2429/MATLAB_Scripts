function DeMod(Comp, FullScale)

Rate = 1024/3;
N = length(Comp);

UnPhase = UnWrap(angle(Comp)/2/pi);
Mod = exp(-i*UnPhase*2*pi);

Result = Comp .* Mod;

if (nargin == 2)
  MySpect(Result, FullScale)
else
  MySpect(Result, 256)
end