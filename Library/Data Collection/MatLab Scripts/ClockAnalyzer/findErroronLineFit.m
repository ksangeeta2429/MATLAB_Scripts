function r = findErroronLineFit(varargin)
    data = (varargin{1})';
    p = polyfit(1:length(data),data',1);
    r = polyval(p,1:length(data)) - data';
end