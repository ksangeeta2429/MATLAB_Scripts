% ReadBin -- Reads raw data from a data sample file (int16's   .data).
% input: string - file name
% output: vector - data points: [I Q I Q I Q...]

function data = ReadBin(fileName)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen(sprintf('%s.data',fileName), 'r');
if (fid < 0)
  fprintf(1,'Could not open file %s.data',fileName);
end
data = fread(fid, inf, 'int16');
fclose(fid);