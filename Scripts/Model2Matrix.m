function [SV_matlab, param, gamma, rho, nRow] = Model2Matrix(fileName,nCol)
% fileName = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Scripts\human_car_model.txt';
% nCol = 18;

Fid = fopen(fileName, 'r');
reData = fread(Fid,inf,'*char');
Data = reData';

tmp = strfind(Data,'total_sv');
tmp1 = strfind(Data,'rho');
nRow = str2double(Data(tmp+9:tmp1-2));

tmp = strfind(Data,'rho');
tmp1 = strfind(Data,'label');
rho = str2double(Data(tmp+4:tmp1-2));

tmp = strfind(Data,'gamma');
tmp1 = strfind(Data,'nr_class');
gamma = str2double(Data(tmp+6:tmp1-2));


SVLocation = strfind(Data,'SV');

Data = Data(SVLocation+2:length(Data));  % only have the matrix right now

param = zeros(1,nRow);

SV_matlab = zeros(nRow, nCol);
for row = 1:nRow
    tmp = strfind(Data, ' ');
    param(row) = str2double(Data(2:tmp(1)-1));
    Data = Data(tmp(1)+1:length(Data));
        
    for col = 1:nCol
        tmp = strfind(Data, sprintf('%d:', col));
        tmp1 = strfind(Data, sprintf(' '));
        if ~isempty(tmp) && tmp(1)==1
            tmp2 = strfind(Data, ':');
            SV_matlab(row,col) = str2double(Data(tmp2(1)+1:tmp1(1)-1));
            Data = Data(tmp1(1)+1:length(Data));
        end   
    end
    
    
        
        
end 

% nRow
% gamma
% rho

fclose(Fid);