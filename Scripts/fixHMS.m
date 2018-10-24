%fix minutes and seconds values such that they are between 0 and 59, h can
%be more than 24
function [h,m,s] = fixHMS(h,m,s)
    min_rem = rem(s,60);
    min_int = fix(s/60);
    if(min_int == 1)
        s = min_rem;
        min_int = 1;
    elseif(min_int > 1)
        s = min_rem;
    end
    m = m + min_int;
    
    hr_rem = rem(m,60);
    hr_int = fix(m/60);
    if(hr_int == 1)
        m = hr_rem;
        hr_int = 1;
    elseif(min_int > 1)
        m = hr_rem;
    end
    h = h + hr_int;
end