function WriteBin(File,Data)

% ReadBin -- Reads raw data from a data sample file (int16's).

Fid = fopen(File, 'w+');
if (Fid < 0)
  'Could not open file'
end

fwrite(Fid, Data, 'int16');

fclose(Fid);