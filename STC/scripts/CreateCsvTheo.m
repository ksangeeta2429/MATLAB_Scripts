function CreateCsvTheo()
clc;clear all; close all;fclose('all');
root='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/';
addpath([root,'radar/STC/scripts/matlab2weka']);
addpath([root,'radar/STC/scripts']);

ClassDef=2;
path='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/data files/new_radar_dataset/clean/full';
fileFullNames=dir(path);
cd(path);
Files=cell(1,length(fileFullNames)-2);  % first 2 file is '.' and '..'
for j=1:length(fileFullNames)-2
    s=fileFullNames(j+2).name;
    k=strfind(s,'.data');
    Files{j}=s(1:k-1);
end

tmp =[60 80 160];
for t=1:length(tmp)
    secondsPerFrame=tmp(t);
    
    sampRate=300;
    %secondsPerFrame=30;
    pointsPerFrame=sampRate*secondsPerFrame;

    ifReg=1;

    f_set=[];
    for j=1:length(Files) % take every file from the set 'Files'
        j
        fileName=Files{j};
        nPeople=ExtractNumFromFileName(fileName);
        if ifReg==0
            classIndex=num2str(classMapping(nPeople,ClassDef));
        else
            classIndex=classMapping(nPeople,ClassDef);
        end

        data = ReadBin(fileName);
        [I,Q,N]=Data2IQ(data);

        nFrames=2*floor(N/pointsPerFrame)-1;
%         nFrames=floor(N/pointsPerFrame);

        f_file=[];
        if nFrames>0       % at least 1 frame, not too short
            for k=1:nFrames      % take every frame from the file
                Iframe=I(1+(k-1)/2*pointsPerFrame:(k+1)/2*pointsPerFrame);
                Qframe=Q(1+(k-1)/2*pointsPerFrame:(k+1)/2*pointsPerFrame);
%                     Iframe=I(1+(k-1)*pointsPerFrame:k*pointsPerFrame);        
%                     Qframe=Q(1+(k-1)*pointsPerFrame:k*pointsPerFrame);

                f_frame=Iframe'+i*Qframe';

                if ifReg==0 %Classification
                    f_frame=num2cell(f_frame);
                end

                f_frame1=[f_frame classIndex]; % add classIndex at the last
                f_file=[f_file;f_frame1];
            end
        end

        f_set=[f_set;f_file];     
    end

    csvwrite(sprintf('radar_%d.csv',secondsPerFrame),f_set,1,0);
end
