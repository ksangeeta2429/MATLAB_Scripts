function Out = SecondMomentMeas(Img, Freq)
    f = abs(Freq');
    Prod = Img*f;
    Out = std(Prod(:));
end

