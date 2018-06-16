% Input: file name
% Do: draw spectrogram

% Input: file name
% Do: draw spectrogram

%print - saves figure as png, but takes about 5 seconds to save after the figure is opened. Do not close the 
%figure for 5 seconds atleast

function Visualize_spectrogram_one_screen(path_data,Fftwindow,sampRate)
clc;close all

WINDOW = 2^nextpow2(Fftwindow); 
NOVERLAP = WINDOW/8; 
NFFT = 2^nextpow2(WINDOW);

cd(path_data);
fileFullNames=dir;
Files={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.data');
    if ~isempty(k) && k>=2 && k+4==length(s)
        Files{i}=s(1:k-1);
        i=i+1;
    end
end



%path_amp = 'amplitude/';
%if exist(path_amp, 'dir') ~= 7
%    mkdir(path_amp);
%    fprintf('INFO: created directory %s\n', path_amp);
%end

%calculate m and n for grid in figure
p = ceil(power(length(Files),0.5));
%p = 5;
n = p; m = p;

figure('units','normalized','outerposition',[0 0 1 1])
for i = 1:64
    fileName = Files{i};
    fprintf('%s    ',fileName)
    % OutFile = strcat(fileName,'.spect.emf');

    data = ReadBin([fileName,'.data']);
    size(data)

    %padding zeros, added by neel
    data = padSignalWithZeros(data,WINDOW,NOVERLAP,NFFT,sampRate);

    [I,Q,N]=Data2IQ(data);

    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,NFFT,sampRate);
    P_dbm_max = max(P_dbm(:));
    %grid off;

    P_dbm_gray=mat2gray(P_dbm,[-60 60]);

    subplot(m,n,i)
    surf(T,F,P_dbm_gray,'EdgeColor','none'); axis tight; view(0,90);axis xy;colormap(jet);caxis([0 1]); axis tight;
    title(fileName)
    %set(gca,'FontSize',40);

end

set(gcf,'PaperPositionMode','auto')
savefig(strcat(path_data,'a_some_spectrograms_',string(NFFT),'_fft'));
print(strcat(path_data,'a_some_Spectrograms_png_',string(NFFT),'_fft'),'-dpng');
end





