function Comp = ReadRadar(FileName)

[R,I] = ReadRadarReIm(FileName);
Comp = (R - mean(R)) + i * (I - mean(I));