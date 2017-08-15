function [Time,Volts] = Read_TDS1001B(Name)

[Time,Volts] = ReadTexScope(Name, 18, '%f ,%f,')