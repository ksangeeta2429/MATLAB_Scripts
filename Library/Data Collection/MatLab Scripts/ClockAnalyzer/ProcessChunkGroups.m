%% Process results to get variance of error for different size linie fits

TotalNumberofChunks = size(r,2);
NumElemperChunk = ChunkSize/2;
% ChunkSize = 100000;
%target_numberofelements = linspace(NumElemperChunk,TotalNumberofChunks*NumElemperChunk,10);
%size_chunkgroups = unique(round(target_numberofelements/NumElemperChunk));
%size_chunkgroups = 1:ceil(TotalNumberofChunks/10):TotalNumberofChunks;
%size_chunkgroups = [1 10 100 1000 10000]
%size_chunkgroups = 1;
size_chunkgroups = [1:1000];

sall = cell(2,length(size_chunkgroups));
for n = 1:length(size_chunkgroups);
    size_chunkgroup = size_chunkgroups(n);
    disp(['Processing ChunkSize = ' num2str(size_chunkgroup)]);
    s = nan(1,floor(TotalNumberofChunks/size_chunkgroup));
    for curchunkgroup_i = 1:floor(TotalNumberofChunks/size_chunkgroup)
        curchunkindexes = (curchunkgroup_i-1)*size_chunkgroup+1 : 1 : size_chunkgroup*curchunkgroup_i;
        
        rtotal = r{1,curchunkindexes(1)};
        for i = curchunkindexes(2:end)
             rtotal = rtotal + r{1,i};
        end
% a = ChunkOperationOnMemoryMapData3(@findExtendedLineFitStats_MM,LAMemMap, ChunkSize,[(curchunkindexes-1)*ChunkSize+1,(curchunkindexes)*ChunkSize]  );
% rtotal = r{1};

%         a = ChunkOperationOnMemoryMapData3(@findExtendedLineFitStats_MM,LAMemMap, ChunkSize,[(curchunkindexes-1)*ChunkSize+1,(curchunkindexes)*ChunkSize]  )
%         e = ChunkOperationOnMemoryMapData3(@findErroronLineFit_MM,LAMemMap, ChunkSize,[(curchunkindexes-1)*ChunkSize+1,(curchunkindexes)*ChunkSize]  )
%         
        % Calculate var of error for this inteval
        numelements = (size_chunkgroup)*NumElemperChunk;
        SSxx = rtotal(1,1) - ((rtotal(1,4))^2)/numelements ;
        SSyy = rtotal(1,2) - ((rtotal(1,5))^2)/numelements ;
        SSxy = rtotal(1,3) - (rtotal(1,4)*rtotal(1,5))/numelements  ;
        s(curchunkgroup_i) = ((SSyy - (SSxy^2)/SSxx)/(numelements-2) ) ;   
               
        if nnz([ s(curchunkgroup_i), SSxx, SSyy, SSxy] <0 )
            a=2;
        end
    end

    sall{1,n} = size_chunkgroup*NumElemperChunk*(1:floor(TotalNumberofChunks/size_chunkgroup));
    sall{2,n} = s;
end

%% Plot Error Variances vs. HSI Clock time

fig_h = figure();
axes_h = gca;
xlabel('HSI Clock Assuming 8 Mhz (s)');
ylabel('Variance of absolute Error after linear fit (s^2)');
hold on;
color_m = hsv(length(size_chunkgroups));
for n = 1:length(size_chunkgroups);
    size_chunkgroup = size_chunkgroups(n);
    plot(sall{1,n}/freq_clock, sall{2,n}/(32*10^6)^2, 'DisplayName', ['ChunkSize = ' num2str(size_chunkgroup*NumElemperChunk)], 'Color',color_m(n,:)  );
end
legend(axes_h,'show');

%% Plot Error Variances vs. midChunGroups
fig_h = figure();
axes_h = gca;
xlabel('ChunkSize');
ylabel('median Variance of absolute Error after linear fit (s^2)');
hold on;
color_m = hsv(length(size_chunkgroups));
x = zeros(1,length(size_chunkgroups));
y = zeros(1,length(size_chunkgroups));
numberofElements = zeros(1,length(size_chunkgroups));
for n = 1:length(size_chunkgroups);
     size_chunkgroup = size_chunkgroups(n);
%     plot(sall{1,n}/freq_clock, sall{2,n}/(32*10^6)^2, 'DisplayName', ['ChunkSize = ' num2str(size_chunkgroup*NumElemperChunk)], 'Color',color_m(n,:)  );
    x(n) = size_chunkgroup*NumElemperChunk  ;
    y(n) = median(sall{2,n}/(32*10^6)^2)  ;
    numberofElements(n) = numel(sall{2,n}/(32*10^6)^2);
    text(x(n),y(n),['\downarrow NumChunks=' num2str(numel(sall{2,n}))]);
end
plot(x,y,'-x','DisplayName', 'median Variance of absolute Error after linear fit' );
k0 = TotalNumberofChunks*NumElemperChunk;

  addTopXAxis('expression', 'k0./argu', 'xLabStr', 'NumberofElements')
  grid on;
%	will use the current axis (handle is not passed to the function), and will compute the new X-tick values according to
%		x' = k0.*10.^argu;
%	where |k0| is a variable whose value has to be set in the 'base' workspace.
%legend(axes_h,'show');

%%
%% Plot Error Variances vs. midChunGroups
fig_h = figure();
axes_h = gca;
xlabel('ChunkSize (s)');
ylabel('median Variance of absolute Error after linear fit (s^2)');
hold on;
color_m = hsv(length(size_chunkgroups));
x = zeros(1,length(size_chunkgroups));
y = zeros(1,length(size_chunkgroups));
sperchunk = NumElemperChunk /(freq_clock);

numberofElements = zeros(1,length(size_chunkgroups));
for n = 1:length(size_chunkgroups);
     size_chunkgroup = size_chunkgroups(n);
%     plot(sall{1,n}/freq_clock, sall{2,n}/(32*10^6)^2, 'DisplayName', ['ChunkSize = ' num2str(size_chunkgroup*NumElemperChunk)], 'Color',color_m(n,:)  );
    x(n) = size_chunkgroup*NumElemperChunk/(freq_clock) ;
    y(n) = median(sall{2,n}/(32*10^6)^2)  ;
    numberofElements(n) = numel(sall{2,n}/(32*10^6)^2);
 %   text(x(n),y(n),['\downarrow NumChunks=' num2str(numel(sall{2,n}))]);
end
plot(x,y,'-x','DisplayName', 'median Variance of absolute Error after linear fit' );
k0 = TotalNumberofChunks*NumElemperChunk/freq_clock;

  addTopXAxis('expression', 'k0./argu', 'xLabStr', 'NumberofElements');
  grid on;
%	will use the current axis (handle is not passed to the function), and will compute the new X-tick values according to
%		x' = k0.*10.^argu;
%	where |k0| is a variable whose value has to be set in the 'base' workspace.
%legend(axes_h,'show');
