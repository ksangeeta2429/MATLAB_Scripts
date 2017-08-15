function ImageScale(Data, OutIndex, Flag,Value0,Value1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Displays an image
%
% Data -- The cell array of 2d image data.
%
% OutIndex -- indicates the index into Data coresponding to the
%   colors (Red, Green, & Blue).
%
% Flags -- 'Sigma', 'XY', or 'Scale'
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NImage = length(Data);
[M,N] = size(Data{1});

%% Create default values
Scale = ones(1,3);
X = [1 : N];
Y = [1 : M];

if strcmp(Flag, 'Simga')
  for i = 1 : NImage
    Sigma(i) = median(median(abs(Data{i})));
    Scale(i) = Value0 / Sigma(i);
  end
end

if strcmp(Flag, 'XY')
  X = Value0; 
  Y = Value1;
else

end

if strcmp(Flag, 'Scale')
  Scale = Value0;
end

%% Create the statistics
for i = 1:3
  if (OutIndex(i) == 0)
    Image(:,:,i) = zeros(M,N);
  else
    j = OutIndex(i);
    Image(:,:,i) = min(Scale(j) .* abs(Data{j}), 1);
  end
end

image(X,Y,Image);

% Some bulk statistics
Size = N*M;

List = unique(OutIndex);
for i = 1 : length(List)
  Sat = sum(sum(Image(:,:,i) == 1));
  disp(sprintf('Frac of saturated = %f', Sat/Size))
end