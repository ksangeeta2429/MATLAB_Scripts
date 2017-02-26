function Index = MatIndex(RowIndex,ColumnIndex,RowSize)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MatIndex - Creates a matrix where each element is the vector index.

NumRow = length(RowIndex);
NumColumn = length(ColumnIndex);

if nargin < 3
  RowSize = NumColumn;
end

%% Zero based
RowStart = repmat(RowSize*(RowIndex - 1)', 1,NumColumn);
ColumnOffset = repmat(ColumnIndex - 1, NumRow,1);

Index = RowStart + ColumnOffset + 1;