function TextWrite(File, Format, varargin)

N = length(varargin{1});

Fd = fopen(File, 'w');

Temp = [varargin{:}];
for i = 1 : N
  fprintf(Fd, Format, Temp(i,:));
end

fclose(Fd);