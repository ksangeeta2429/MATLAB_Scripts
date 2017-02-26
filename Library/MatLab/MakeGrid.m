function [XMat,YMat] = MakeGrid(XTicks, YTicks)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MakeGrid -- Creates a matrix of X & Y for specified tick values

NX = length(XTicks);
NY = length(YTicks);

XMat = kron(XTicks, ones(NY,1));
YMat = kron(ones(1,NX), YTicks');