function [SSx, SSy, Sxy, Sy, Sx] = findExtendedLineFitStats(varargin)
    curLogicClocks = (varargin{1})';
    curIndexNumbers = varargin{2};
    %Keep Stats
    SSx =  sum(curIndexNumbers);
    SSy =  sum(curLogicClocks);
    Sxy =  sum(curLogicClocks.*double(curIndexNumbers));
    Sy =  sum(curLogicClocks);
    Sx =  sum(curIndexNumbers);
end