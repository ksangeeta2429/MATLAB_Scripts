function WriteComp(File, Comp)

Fid = fopen(File, 'w');
if (Fid < 0)
  ERROR('Could not open file');
end

N = length(Comp);

FlatData([1 : 2 : 2*N - 1]) = real(Comp);
FlatData([2 : 2 : 2*N]) = imag(Comp);

fwrite(Fid, FlatData, 'int16');

fclose(Fid);