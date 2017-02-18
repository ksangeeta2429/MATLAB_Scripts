function plotspect(filename,window,overlap,nfft,samprate)

    %figure;
    OutFile = strcat(filename,'.spect.emf');
    OutFileI = strcat(filename,'.I.spect.emf');
    OutFileQ = strcat(filename,'.Q.spect.emf');
    
    OutFile1 = strcat(filename,'.spect.first5k.emf');
    OutFile2 = strcat(filename,'.spect.last5k.emf');
    
    
    Data = ReadBin(sprintf('%s.data',filename));
    N = length(Data);
    
    Idata = Data([1:2:N-1]);
    Qdata = Data([2:2:N]);
    
    %Idata(find(Idata>=4096)) = Idata(find(Idata>=4096)) - 4096;
    %Qdata(find(Qdata>=4096)) = Qdata(find(Qdata>=4096)) - 4096;
    %Idata = Id(startTime*samprate+1:endTime*samprate);
    %Qdata = Qd(startTime*samprate+1:endTime*samprate);

    %clear('Id'); clear('Qd');
        
    dcI = median(Idata);
    dcQ = median(Qdata);

    Idata = Idata - dcI;
    Qdata = Qdata - dcQ;
    
    Comp = Idata + i*Qdata;
    
    %clear('Idata'); clear('Qdata');
    %spectrogram(Comp, 256,256-32,256,341);

    %close all;
    %figure('Position',[100 100 640  480]);
    
    spectrogram(Comp, window, overlap,nfft,samprate);
    clear('Comp');

    %print ('-dmeta', OutFile);
    %axis([0 5000 0 12]);
    %print ('-dmeta', OutFile1);
    %axis([44100-5000 44100 0 12]);
    %print ('-dmeta', OutFile2);
    %figure('Position',[100 100 1200 800]);
    %spectrogram(Idata, window, overlap,nfft,samprate);
    %print ('-dmeta', OutFileI);
    
    %figure('Position',[100 100 1200 800]);
    %spectrogram(Qdata, window, overlap,nfft,samprate);
    %print ('-dmeta', OutFileQ);
    
    fclose('all');
    
end
    

