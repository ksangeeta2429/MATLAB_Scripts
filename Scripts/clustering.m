% given a matrix of centroids of clusters, every row is a feature vector of
% a centroid of a cluster.
% compute the summation of the distance of one centroid to all the other
% centroids.

% should copy the texts (such as below) from weka clustering output

% f1          296816.8116  299460.305 280555.6611 308928.7056 292142.5533
% f2                   24          21          26          25          25
% f3                  419       165.5         544         897        1411
% f4                 44.5          21          52          81         116
% f5                   18           6          26          42          70
% f6             129.2258     36.1615    155.3333    495.8631   1036.5934
% f7                   70          58          70        89.5         115
% f8                  212          62         259         511         914
% f9                   24          11          28          50          79
% f10                   8           1          11        23.5          46
% f11             46.8315     11.7051     61.5606    212.0698    451.0956
% f12                  57          51          55          70          96



% function clustering()



cd('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Records');
fid = fopen('ClusterCentroids.txt','r');
data = fread(fid,inf,'*char');
data = data';

thrDistSum = 35;
thrSize = 10;

nFeature = 60;


size=[(48)       (29)       (54)       (53)       (16)       (46)       (47)       (18)       (39)       (29)       (53)       (31)       (23)];
nClass = length(size)

rows = strsplit(data,char(13));
centroids = zeros(nFeature,nClass);
for i=1:nFeature
    row = strsplit(rows{i},' ');
    centroids(i,:) = str2double(row(3:length(row)));
end

centroids = centroids';


distSum = zeros(1, nClass);
for i=1:nClass
    for j=1:nClass
        if j~=i
            distSum(i) = distSum(i) + sqrt(sum((centroids(i,:)-centroids(j,:)).^2));
        end
    end
end


distSum
for i=1:nClass
    if distSum(i)>thrDistSum && size(i)<thrSize
        i
    end
end
            