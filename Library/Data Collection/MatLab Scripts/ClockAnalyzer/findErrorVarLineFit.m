function r = findErrorVarLineFit(varargin)
    data = (varargin{1})';
    r = var(findErroronLineFit(data));
end