function [] = WriteBin( File, Data )
%WriteBin -- writes data to file (int16's).
%
% Input:
% File - name of file to write.
% Data - variable to write to file.
%
% Output:

%TODO: verify data will fit Int16.

Fid = fopen(File, 'w+');
if (Fid < 0)
	error( 'Could not open file' );
end

fwrite(Fid, Data, 'int16');

fclose(Fid);