mainpath = '/home/neel/box.com/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/Data_Repository/Bike data/Oct 21 2017/';
subpath = 'humans_first_window_start/test2/';
file = 'r1_c2_cut121_human';
fileName = strcat(mainpath,subpath,file);

[I,Q,N]=Data2IQ(ReadBin([fileName,'.data']));  %Extracting I and Q component from data

dcI = median(I);
dcQ = median(Q);

Data = (I-dcI) + 1i*(Q-dcQ);

thr_sqr_matlab = 50 * 64^2;

Img = AnomImage(Data, 64, 8, 250, 64, thr_sqr_matlab,0,0);

a = Img';
a(:,1)
[start,stop] = getContinuousBand(a(:,1),4,7)