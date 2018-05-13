function [ str_fieldwidth ] = num2width( num )
%num2width - find width of number
%
% Input:
% num - whole number
%
% Output:
% str_fieldwidth - string number of digits needed to represent num
%
% Notes: use to find leading zero field width for format specifier num2str

numzeros = ceil( log10( length(num)+1 ) );
str_fieldwidth = num2str(numzeros);
if str_fieldwidth == '0'
    str_fieldwidth = '';
end
