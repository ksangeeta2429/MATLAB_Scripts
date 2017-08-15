function Result = ParRes(varargin)

Res = [varargin{:}];
Admit = 1 ./ Res;
Result = 1 / sum(Admit);