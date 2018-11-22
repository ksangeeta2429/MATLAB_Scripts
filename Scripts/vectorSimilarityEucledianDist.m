%feature_vector_CSharp = [1247, 180, 762.476135, 125, 34.8333321, 121, 113, 571, 99, 21.333334,49463, 40537, 37546, 22931, 116];
%feature_vector_matlab = [1210, 187, 947.80,     121, 34.5,       121, 113, 566, 97, 19.83,    48381, 41368, 37112, 22443, 116];

feature_vector_CSharp = [3786,184,2254.24902,127,10.136364,125,120,1771,99,6.18,141171,115876,106316,67778,120];
feature_vector_matlab = [3747,182,2632.114130,125,9.478261,121,115,1782,97,5.82,138773,118502,105257,67172,117];

%feature_vector_CSharp = [1108,58,99.6725159,76,4.11111116,59,58,35,43,0.222222224,10628,4677,3177,564,48];
%feature_vector_matlab = [777,43,75.76,     75,3.11,      59,53,20,34,0.22,       7926, 4352,3034,434,49];

max = [12502,528089,256,128,62.500000,128.000000,128,6643,128,42.166667,3552.935897,2737.025641,2444.923077,1267.619048,256];
min = [18,635,22,1,0.448454,-1.000000,-1,0,-1,0,0,0,0,0,0];
%{
for i = 1:length(feature_vector_CSharp)
    feature_vector_CSharp(i) = (feature_vector_CSharp(i)-min(i))/(max(i)-min(i));
    feature_vector_matlab(i) = (feature_vector_matlab(i)-min(i))/(max(i)-min(i));
end
%}
feature_vector_CSharp

eucl_dist  = sqrt(sum((feature_vector_matlab - feature_vector_CSharp) .^ 2));

eucl_sim = 1/exp(eucl_dist);

fprintf('Euclidean Distance : %f  Euclidean Similarity : %f\n',eucl_dist,eucl_sim);

percentage_diff = [];
for i = 1:length(feature_vector_CSharp)
    
    percentage_diff(i) = abs(feature_vector_matlab(i) - feature_vector_CSharp(i))*100/feature_vector_matlab(i);
    fprintf('%f,',percentage_diff(i));
end
fprintf('\n');
percentage_diff;
