% specifically for writing the Support Vectors to C# program
% and writing all the other parameters to make sure there is only one copy
% to switch between different models to speed up the try of models
% only need to copy nSV once more because it is a const value in C# and
% cannot be put in the code

function Generate2DArrInCsharp(OutIndex,SV_matlab,param,gamma,rho,feature_min,scalingFactors)
SetPath
SetEnvironment

fid = fopen([g_str_pathbase_radar,'/IIITDemo/Models/ModelParameters/ModelParameters_Csharp',num2str(OutIndex),'.txt'],'w');
% fid = fopen(['C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Models\ModelParameters\ModelParameters_Csharp',num2str(OutIndex),'.txt'],'w');

%% write rho and gamma
fprintf(fid, ['rho = ', num2str(rho), 'f;\n']);
fprintf(fid, ['gamma = ', num2str(gamma), 'f;\n']);

%% write the SVs to ram or NOR
%%%%%% double 2d
% fprintf(fid,'sv = new double[nSV][];\n');
% for i = 1:size(SV_matlab,1)
%     fprintf(fid, ['sv[',num2str(i-1),'] = new double[nFeature] {']);
%     fprintf(fid, GenerateArrInCsharp(SV_matlab(i,:),0));
%     fprintf(fid, '};\n');
% end

%%%%%% float 2d
% fprintf(fid,'sv = new float[nSV][];\n');
% for i = 1:size(SV_matlab,1)
%     fprintf(fid, ['sv[',num2str(i-1),'] = new float[nFeature] {']);
%     fprintf(fid, GenerateArrInCsharp(SV_matlab(i,:),1));
%     fprintf(fid, '};\n');
% end

%%%%%% float 1d
fprintf(fid,'sv1d = new float[nSV*nFeature]{\n');
for i = 1:size(SV_matlab,1)
    fprintf(fid, [GenerateArrInCsharp(SV_matlab(i,:),1),', ']);
end
fprintf(fid,'\n};\n');

%% write the param
fprintf(fid,'weight = new float[nSV] {');
fprintf(fid,GenerateArrInCsharp(param,1));
fprintf(fid,'};\n');

%% write the feature_min and scalingFactors
fprintf(fid,'feature_min = new float[nFeature] {');
fprintf(fid,GenerateArrInCsharp(feature_min,1));
fprintf(fid,'};\n');

fprintf(fid,'scalingFactors = new float[nFeature] {');
fprintf(fid,GenerateArrInCsharp(scalingFactors,1));
fprintf(fid,'};\n\n');

%% write sv, float, 1d




fclose(fid);