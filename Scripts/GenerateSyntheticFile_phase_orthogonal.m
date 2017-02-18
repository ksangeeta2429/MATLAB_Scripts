function GenerateSyntheticFile_phase_orthogonal(fileName,R,d)

data = ReadBin([fileName,'.data']);

T1 = length(data);
T2 = round(T1*sqrt(R^2-d^2)/R);
data_synthetic = zeros(1,T2);
for t2 = 1:T2
    t1 = round((1-sqrt(((1-t2/T2)*sqrt(R^2-d^2))^2+d^2)/R)*T1);  
    if t1<=0
        t1=1;
    end
    data_synthetic(t2) = data(t1);
end

WriteBin(['.\synthetic3\',fileName,'_synthetic_phase_orthogonal_',num2str(R),'_',num2str(d),'.data'],data_synthetic);
