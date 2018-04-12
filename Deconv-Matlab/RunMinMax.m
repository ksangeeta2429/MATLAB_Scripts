function [Min,Max] = RunMinMax(Data, M)

Tab = RunTab(Data,M);
Min = min(Tab, 2);
Max = max(Tab, 2);