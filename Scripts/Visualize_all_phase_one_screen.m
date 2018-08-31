% clear all;
function Visualize_all_phase_one_screen(path_data,sampRate)
clc;close all

SetEnvironment
SetPath

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
%p = 8
n = p; m = p;
x = 0:400:3000;
figure('units','normalized','outerposition',[0 0 1 1])
for i=1:64 % take every file from the set 'Files'
    if(rem(i,10) == 0)
        sprintf('%dth file is processing: %s\n',i,char(Files{i})) % the i-th file is processing
    end
    fileName=Files{i};
    fprintf('%s    ',fileName);
    
    data = ReadBin([fileName,'.data']);
    [I,Q,N]=Data2IQ(data);
    
    dc_I = median(I);
    dc_Q = median(Q);
    Data= (I-dc_I) + 1j*(Q-dc_Q);
    
    Range = UnWrap(angle(Data)/2/pi, -0.5, 0.5)* 2*pi*4096/1e6;

    Index = ([1:N])/sampRate;
    subplot(m,n,i);
    
    plot(Index(1:length(Range)),Range,'b');   
    title(fileName)
    
end

set(gcf,'PaperPositionMode','auto')
savefig(strcat(path_data,'a_some_phase'));
print(strcat(path_data,'a_some_phase_png'),'-dpng');

end