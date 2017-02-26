function r = findErrorVarLineFit_MM(LAMemMap,curIndexNumbers)
    r = zeros(1,2); % the first one is the mean the second one is the absolute value
    e =  findErroronLineFit_MM(LAMemMap,curIndexNumbers);
    r(1) = mean(abs(e));
    r(2) = var(abs(e));
end