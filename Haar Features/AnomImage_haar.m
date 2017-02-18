function x=AnomImage_haar(Data, levels, meanBack, stdBack, deviation)

    Y=haar_feature(Data,levels);
    x=Y-(meanBack+deviation*stdBack); % Energies in each frequency bin above background clutter
end