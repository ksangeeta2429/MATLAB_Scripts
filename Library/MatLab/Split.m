function varargout = Split(List)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Split -- Take an list argument and split it into seperate outputs.

N = size(List,2);

if (N ~= nargout)
  error('Size missmatch')
end

for i = 1 : N
 varargout{i} = List(:,i);
end