% initState is the state of the state machine
% sometimes during the demo you may have to reset nodes or
% something crashes on the PC
% specifying the initState lets you restart from the appropriate state,
% e.g. you don't have to recollect noise data 
% n = number of nodes, assumes that nodes are numbered 1..n

%function STCDemo(run, initState, n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run=1;
initState = 0;
n=1;


trace = 1;
numNodes = n;
detectActive = zeros(1,numNodes);

%run = 1;
addpath('..\Features\VelocityBased')
addpath('..\Features\PhaseBased')
addpath('..\Features\FftBased')
addpath('..\Features\AcclnBased')
addpath('..\MatlabLibrary')

%%%%%% LIST OF STATES %%%%%
RESET_STATE = 0;
WAITING_FOR_NOISE = 1;
DONE_NOISE = 2;
WAITING_FOR_DETECT = 3;
WAITING_FOR_DATA = 4;
READY_TO_CLASSIFY = 5;

eventActive = 0;
currState = initState;
dispstr='';

%%% VIZ STUFF
mainscr = figure; % main screen to display detections and classifier result
statusscr = figure; % displays node status = time of last rcvd msg
spectfig = figure; % plots some feature (currently spectrogram) about target

figure(mainscr);
ha = axes('units','normalized','position',[0 0 1 1]);
% Move the background axes to the bottom
uistack(ha,'bottom');
% Load in a background image and display it using the correct colors
% The image used below, is in the Image Processing Toolbox. If you do not have %access to this toolbox, you can use another image file instead.
I=imread('images/newbg.jpg');
hi = imagesc(I);
colormap gray;
% Turn the handlevisibility off so that we don't inadvertently plot into the axes again
% Also, make the axes invisible
set(ha,'XTick',[],'YTick',[]);

% This creates the 'background' axes
hc = axes('units','normalized','position',[0 0 1 1],'Visible','off');
set(hc,'XTick',[],'YTick',[]);

% This creates the 'background' axes
hc = axes('units','normalized','position',[0 0 1 1]);
set(hc,'handlevisibility','off', 'visible','off');

figure(statusscr);
ha = axes('units','normalized','position',[0 0 1 1],'Visible','off');
% Move the background axes to the bottom
uistack(ha,'bottom');
% Load in a background image and display it using the correct colors
% The image used below, is in the Image Processing Toolbox. If you do not have %access to this toolbox, you can use another image file instead.
I=imread('images/status-bg.jpg');
hi = imagesc(I);
colormap gray;
% Turn the handlevisibility off so that we don't inadvertently plot into the axes again
% Also, make the axes invisible
set(ha,'XTick',[],'YTick',[]);

% This creates the 'background' axes
hc = axes('units','normalized','position',[0 0 1 1],'Visible','off');
set(hc,'XTick',[],'YTick',[]);

figure(mainscr);

% node topology, change according to deployment
nodeLocationX = [100 300 400 400];
nodeLocationY = [100 100 200 400];

statusLocationX = [140 230 310 390];
statusLocationY = [105 290 105 290];

nowtime = clock;
lastUpdated = [nowtime; nowtime; nowtime; nowtime];

plotMotes(detectActive);
updateNetworkStatus(1);

if ~libisloaded('STCDemoSF')
    loadlibrary('STCDemoSF','MatLab.h')
end

calllib('STCDemoSF','init',6) %Virutal COM port number for the base station Tmote

readarray = [1:44];
rp = libpointer('int16Ptr',readarray);

while (1)
    i = 0;
    if (currState == RESET_STATE)
        % dest = 255 (broadcast)
        % type = 10 (start noise sampling)
        fprintf(1,'Sending Noise start command\n');
        calllib('STCDemoSF','writeVals',255,10);
        pause(0.25);
        calllib('STCDemoSF','writeVals',255,10);
        pause(0.25);
        calllib('STCDemoSF','writeVals',255,10);
          %  i = i + 1;
        pause(32);
        fprintf(1,'Changing State to WAITING_FOR_NOISE\n');
        currState = WAITING_FOR_NOISE;
    end

    if (currState == WAITING_FOR_NOISE)
        nodeDone = 0;

        %get noise data from all
        for j=1:numNodes
            fid = fopen(sprintf('logs/noise%d_%d.data',j,run),'w');
            ftemp = fopen(sprintf('logs/noise%d_%d.data',j,run),'w');
            nodeDone = 0;
            
            missedPkts = 0;
            lastSeq = -1;
            
            pause(1);
            fprintf(1,'Sending download noise cmd for node %d\n',j);
            % dest = j
            % type = 11 (start sending noise)
            calllib('STCDemoSF','writeVals',j,11);
            pause(0.25);        
            calllib('STCDemoSF','writeVals',j,11);
            pause(0.25);        
            calllib('STCDemoSF','writeVals',j,11);
            
            while (nodeDone == 0)
                calllib('STCDemoSF','readVals',rp);
                result = get(rp,'Value');
                fprintf('%d \t',result(1));
                fprintf('%d \t',result(2));
                fprintf('%d \t',result(3));
                fprintf('%d \t',result(4));
                fprintf('%d \t',result(5));
                fprintf('%d \t',result(6));
                recd = result(1);

                if (recd == 1)
                    src = result(3);
                    cnt = result(4);
                    type = result(5);

                    if (src == j && type == 12)
                        missedPkts = missedPkts + cnt - lastSeq - 1;
                        lastSeq = cnt;
                        for k=1:1:10
                            fprintf('%d \t', result(5+k));
                            fwrite(fid,result(5+k),'int16');
                            fwrite(ftemp,result(5+k));
                        end
                    end

                    if (src ==j && type == 13) % noise done
                        nodeDone = 1;
                        fprintf(1,'Finished noise download for node %d, Missed pkts = %d\n',j, missedPkts);
                        updateNetworkStatus(j);
                    end
                else
                    pause(0.01);
                end
                fprintf('\n');
            end

            fclose(fid);
        end
        currState = DONE_NOISE;
    end

    if (currState == DONE_NOISE)
        pause(5);
        fprintf(1,'Sending detect start command\n');
        % dest = broadcast
        % type = 13 (start detecting)
        calllib('STCDemoSF','writeVals',255,94);
        pause(0.25);
        calllib('STCDemoSF','writeVals',255,94);
        pause(0.25);
        calllib('STCDemoSF','writeVals',255,94);
        currState = WAITING_FOR_DETECT;
    end

    if (currState == WAITING_FOR_DETECT)
        gotAllDetects = 0;
        numDetects = 0;
        for p=1:1:numNodes
            detectActive(p) = 0;
        end

        plotMotes(detectActive);
              
        while (gotAllDetects == 0)

            calllib('STCDemoSF','readVals',rp);
            result = get(rp,'Value');

            recd = result(1);

            if (recd == 0)
                pause(0.5);
            else
                src = result(3);
                cnt = result(4);
                type = result(5);

                if (type == 15) % detect message
                    if (detectActive(src) == 0) % new node
                        fprintf(1,'Received new detect from %d\n',src);
                        tic;
                        if (numDetects == 0) % first one
                            numDetects = 1;
                            detectActive(src) = 1;
                        else
                            numDetects = numDetects + 1;
                            detectActive(src) = 1;
                        end
                        
                        plotMotes(detectActive);
                        updateNetworkStatus(src);
                    end
                end
            end

            % if all have detected or no detects for a while
            if (numDetects > 0)
                if (numDetects == numNodes || toc > 15)
                    gotAllDetects = 1;
                    fprintf(1,'Finished receiving all detects\n');
                end
            end
        end

        currState = WAITING_FOR_DATA;
    end

    if (currState == WAITING_FOR_DATA)
        for j=1:1:numNodes
            if (detectActive(j) == 1)
                nodeDone = 0;
            
                missedPkts = 0;
                lastSeq = -1;
            
                fid = fopen(sprintf('logs/target%d_%d_%d.data',j,run,trace),'w');
                %disp('Pausing for 10 sec');
                %pause(10);
                fprintf(1,'Sending data download command to node %d\n',j);
                % dest = j
                % type = 15 (start sending data)
                calllib('STCDemoSF','writeVals',j,16);
                pause(0.25);        
                calllib('STCDemoSF','writeVals',j,16);
                pause(0.25);        
                calllib('STCDemoSF','writeVals',j,16);
                pause(1);
               
                tic;
                while (nodeDone == 0)
                    calllib('STCDemoSF','readVals',rp);
                    result = get(rp,'Value');
                    fprintf('%d \t',result(1));
                    fprintf('%d \t',result(2));
                    fprintf('%d \t',result(3));
                    fprintf('%d \t',result(4));
                    fprintf('%d \t',result(5));
                    fprintf('%d \t',result(6));
                    fprintf('\n');
                    recd = result(1);

                    if (recd == 1)
                        src = result(3);
                        cnt = result(4);
                        type = result(5);

                        if (src == j && type == 17)
                            tic;
                            
                            missedPkts = missedPkts + cnt - lastSeq - 1;
                            lastSeq = cnt;
                            
                            for k=1:1:10
                                if (result(5+k) > 0)
                                    fwrite(fid,result(5+k),'int16');
                                end
                            end
                        end

                        if (src == j && type == 18) % data done
                            nodeDone = 1;
                            fprintf(1,'Finished download from %d, Missed %d out of %d\n',j,missedPkts, lastSeq+1);
                            updateNetworkStatus(j);
                        end
                    else
                        if (toc > 10)
                            fprintf(1,'Timing out download from %d, Missed %d out of %d \n',j, missedPkts, lastSeq+1);
                            detectActive(j) = 0;
                            nodeDone = 1;
                        end
                        pause(0.01);
                    end
                end

                fclose(fid);
            end
        end
        currState = READY_TO_CLASSIFY;
    end          

    if (currState == READY_TO_CLASSIFY)
        fprintf('Done with this round: Calculating  feature values\n');
        numDogs = 0;
        numHumans = 0;
        
        figure(mainscr);
        hold on;
        
        for j=1:1:numNodes
            if (detectActive(j) == 1)
                fname = sprintf('logs/target%d_%d_%d.data',j,run,trace);
                f_details = dir(fname)
                disp (['Classifying for node:' int2str(j)]);
                if(f_details.bytes > 0)
                    calcFeaturesHumanCar(sprintf('logs/noise%d_%d.data',j,run),fname , sprintf('logs/features%d_%d_%d.txt',j,run,trace));
                    f_details_features = dir(sprintf('logs/features%d_%d_%d.txt',j,run,trace));
                    if(f_details_features.bytes == 0)
                        continue;
                    end
                    cmdstr = sprintf('svm-predict.exe logs\\features%d_%d_%d.txt human_car_model.txt logs\\human_car_out%d_%d_%d.txt',j,run,trace,j,run,trace);
                    dos(cmdstr);

                    fid = fopen(sprintf('logs/human_car_out%d_%d_%d.txt',j,run,trace),'r+');
                    Line = textscan(fid,'%d',1);
                    if (Line{1} == 1)
                        %text(nodeLocationX(j)-25,nodeLocationY(j)-25,'Dog','FontSize',14,'Color','red');
                        numDogs = numDogs + 1;
                    else
                        %text(nodeLocationX(j)-25,nodeLocationY(j)-25,'Human','FontSize',14,'Color','red');
                        numHumans = numHumans + 1;
                    end
                    fclose(fid);
                else
                    disp(['Zero target data for node: ' int2str(j)]);
                end
            end
        end
               
        %fprintf(1, '%d classified as car and %d as human\n',numDogs,numHumans);
        if (numDogs == 0 && numHumans == 0)
            text (1,1,[sprintf('Not enough data to classify',numDogs,numHumans)],'Units','inches', 'FontSize',16, 'Color','red');
        elseif (numDogs >= numHumans)
            %text (1,1,[sprintf('Target is a Human',numDogs,numHumans)],'Units','inches', 'FontSize',16, 'Color','red');
            text (1,1,[sprintf('Target is a Dog',numDogs,numHumans)],'Units','inches', 'FontSize',16, 'Color','red');
        else
            text (1,1,[sprintf('Target is a Human',numDogs,numHumans)],'Units','inches', 'FontSize',16, 'Color','red');
        end
        
        hold off;
        k = sum(detectActive);
        plotIndex = 1;
        figure(spectfig);
        for j=1:1:numNodes
            if (detectActive(j)==1)
                subplot(k,1,plotIndex);
                plotspect(sprintf('logs/target%d_%d_%d',j,run,trace), 256, 256-32,256,333);
                plotIndex = plotIndex+1;
            end
        end
        pause(5);
        %close(spectfig);
        currState = DONE_NOISE;
        trace = trace + 1;
    end

end

function plotMotes(state)
    figure(mainscr);

    for i=1:numNodes
        if (state(i) == 1)
            plot(nodeLocationX(i), nodeLocationY(i), '-mo', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'r', 'MarkerSize',10);
        else
            plot(nodeLocationX(i), nodeLocationY(i), '-mo', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'y', 'MarkerSize',10);
        end
        hold on;
    end
    axis([0 500 0 500]);
    set(gca, 'color', 'none') ; 
    pause(0.1);
    hold off;
end

function updateNetworkStatus(j)
    figure(statusscr);

    lastUpdated(j,:) = clock;
    
    for i=1:numNodes
        plot(statusLocationX(i), statusLocationY(i), '-mo', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'y', 'MarkerSize',10);
        hold on;
        text(statusLocationX(i)-25, statusLocationY(i)-30,[sprintf('%d.%d.%2.0f',lastUpdated(i,4),lastUpdated(i,5),lastUpdated(i,6));],'FontSize',14,'Color','blue');
    end
    axis([0 500 0 500]);
    set(gca, 'color', 'none') ; 
    pause(0.1);
    hold off;
    figure(mainscr);
end

function tabulate(t,c1,c2,c3)

axis([0 600 0 600]);

text(200,500,'Node id');
text(300,500,'Time');
text(400,500,'Voltage');

for i=1:1:length(c1)
    text(200,500-30*i,sprintf(' %d',c1(i)));
    text(300,500-30*i,sprintf(' %d',round(toc - c2(i))));
    text(400,500-30*i,sprintf(' %6.3f',c3(i)));
end

end

end