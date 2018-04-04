function line=edge(mat)
% mat=P01;

[M N]=size(mat);
for j=1:N
    i=round(M/2);
    while mat(i,j)==0 && i>=2
        i=i-1;
    end
    if i==1 && mat(i,j)==0      % i==1 only if the above loop is run to the end
        i=0;
    end
    line(j)=i;
end
% figure;plot(1:N,line);
