% compute the separability from arff file

SetEnvironment

addpath(strcat(g_str_pathbase_radar,'\IIITDemo\Scripts\matlab2weka'));

cd(strcat(g_str_pathbase_radar,'\IIITDemo\Arff'));
n1 = 25;
n2 = 14;
nf = 12;

instances = loadARFF('radar76.arff');
f = instances.attributeToDoubleArray(nf);
%class1 - dog
f1 = f(1:n1);
mean1 = mean(f1);
std1 = std(f1);
%class0 - human
f0 = f(n1+1:length(f));
mean0 = mean(f0);
std0 = std(f0);
% Fisher discriminant method 
distributionDistanceFactor = (mean0-mean1)^2/(std0^2+std1^2)


instances = loadARFF('radar82.arff');
f = instances.attributeToDoubleArray(nf);
%class1 - dog
f1 = f(1:n2);
mean1 = mean(f1);
std1 = std(f1);
%class0 - human
f0 = f(n2+1:length(f));
mean0 = mean(f0);
std0 = std(f0);
% Fisher discriminant method 
distributionDistanceFactor = (mean0-mean1)^2/(std0^2+std1^2)


instances = loadARFF('radar83.arff');
f = instances.attributeToDoubleArray(nf);
%class1 - dog
f1 = f(1:n1+n2);
mean1 = mean(f1);
std1 = std(f1);
%class0 - human
f0 = f(n1+n2+1:length(f));
mean0 = mean(f0);
std0 = std(f0);
% Fisher discriminant method 
distributionDistanceFactor = (mean0-mean1)^2/(std0^2+std1^2)