function Pic = MakePic(Data, OutIndex, Flag,Value)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Displays an image
%
% Data -- The cell array of 2d image data.
%
% OutIndex -- indicates the index into Data coresponding to the
%   colors (Red, Green, & Blue).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NImage = length(Data);
[M,N] = size(Data{1});

%% Create default values

if nargin < 3
  Scale = ones(1,3);
else
  if strcmp(Flag, 'Sigma')
    for i = 1 : NImage
      Sigma(i) = median(median(abs(Data{i})));
      Scale(i) = Value / Sigma(i);
    end
  elseif strcmp(Flag, 'Scale')
    Scale = Value;
  else
    ERROR('Unrecognized flag');
  end
end

%% Create the statistics
for i = 1:3
  if (OutIndex(i) == 0)
    Pic(:,:,i) = zeros(M,N);
  else
    j = OutIndex(i);
    Pic(:,:,i) = min(Scale(j) .* abs(Data{j}), 1);
  end
end

% Some bulk statistics
Size = N*M;

List = unique(OutIndex);
for i = 1 : length(List)
  Sat = sum(sum(Pic(:,:,i) == 1));
  disp(sprintf('Frac of saturated = %f', Sat/Size))
end