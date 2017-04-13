function Comp = ReadRadarBiasSubtracted(FileName_IQ, outputtype)

  if nargin < 2
    outputtype = 'iplusq';
  end

%[I,Q] = ReadRadarReIm(FileName);
Samp = dlmread(FileName_IQ);
switch outputtype
    case 'complex' % I+iQ
        Comp = Samp(:,1) + i * Samp(:,2);
    case 'modiplusmodq' % |I|+|Q|
        Comp = abs(Samp(:,1)) + abs(Samp(:,2));
    otherwise % I+Q
        Comp = Samp(:,1) + Samp(:,2);
end