path_arff_1 = 'C:\Users\DL287WIN1\Desktop\jin_envs_matlab.arff';
path_arff_2 = 'C:\Users\DL287WIN1\Desktop\jin_envs_emote.arff';

instances_1 = loadARFF(path_arff_1);
instances_2 = loadARFF(path_arff_2);

N1=instances_1.numAttributes-1;
M1=instances_1.numInstances();

N2=instances_2.numAttributes-1;
M2=instances_2.numInstances();

if M1~=M2 || N1 ~=N2
    error('Message: Incompatible ARFF files! Numbers of attributes and numbers of instances must be same.');
end

instances1_matrix=zeros(M1,N1);
instances2_matrix=zeros(M1,N1);
pct_diff_matrix=zeros(M1,N1);

for j=1:N1
    instances1_matrix(:,j) = instances_1.attributeToDoubleArray(j-1);
    instances2_matrix(:,j) = instances_2.attributeToDoubleArray(j-1);
end

diff_matrix = abs(instances1_matrix-instances2_matrix);
[maxDiff,ind] = max(diff_matrix(:));
[max_x,max_y] = ind2sub(size(diff_matrix),ind);

for i=1:M1
    for j=1:N1
        pct_diff_matrix(i,j) = diff_matrix(i,j)*100/min(instances1_matrix(i,j),instances2_matrix(i,j));
    end
end

[maxpctDiff,ind] = max(pct_diff_matrix(:));
[maxpct_x,maxpct_y] = ind2sub(size(pct_diff_matrix),ind);