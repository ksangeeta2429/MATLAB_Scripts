Comp = ReadRadar('C:\Users\royd\Desktop\SenSys10\data\2-CoffmanPark-Tree\Coffman-tree-2m.data');
[~,UnRots]=ParameterAnalysis(Comp,250,'test',6,0,2,3,1);
NoiseCdf_IPSN(UnRots,'r46-coffman_noIQ',250,0.5);

Comp = ReadRadar('C:\Users\royd\Desktop\SenSys10\data\4-OSU-Garage\r46-garage.data');
[~,UnRots]=ParameterAnalysis(Comp,250,'test',6,0,2,3,1);
NoiseCdf_IPSN(UnRots,'r46-garage_noIQ',250,0.5);

Comp = ReadRadar('C:\Users\royd\Desktop\SenSys10\data\3-AveryPark-2trees\r46-2trees-3m.data');
[~,UnRots]=ParameterAnalysis(Comp,250,'test',6,0,2,3,1);
NoiseCdf_IPSN(UnRots,'r46-Avery_noIQ',250,0.5);

Comp = ReadRadar('C:\Users\royd\Desktop\SenSys10\data\1-CornField-Snow\snow-no-targets.data');
[~,UnRots]=ParameterAnalysis(Comp,250,'test',6,0,2,3,1);
NoiseCdf_IPSN(UnRots,'r46-Cornfield_noIQ',250,0.5);


%%

Comp = ReadRadar('C:\Users\royd\Desktop\SenSys10\data\2-CoffmanPark-Tree\Coffman-tree-2m.data');
[~,UnRots]=ParameterAnalysis(Comp,250,'test',6,87.03,2,3,1);
NoiseCdf_IPSN(UnRots,'r46-coffman_IQ',250,0.5);

Comp = ReadRadar('C:\Users\royd\Desktop\SenSys10\data\4-OSU-Garage\r46-garage.data');
[~,UnRots]=ParameterAnalysis(Comp,250,'test',6,24.03,2,3,1);
NoiseCdf_IPSN(UnRots,'r46-garage_IQ',250,0.5);

Comp = ReadRadar('C:\Users\royd\Desktop\SenSys10\data\3-AveryPark-2trees\r46-2trees-3m.data');
[~,UnRots]=ParameterAnalysis(Comp,250,'test',6,247.59,2,3,1);
NoiseCdf_IPSN(UnRots,'r46-Avery_IQ',250,0.5);

Comp = ReadRadar('C:\Users\royd\Desktop\SenSys10\data\1-CornField-Snow\snow-no-targets.data');
[~,UnRots]=ParameterAnalysis(Comp,250,'test',6,17.37,2,3,1);
NoiseCdf_IPSN(UnRots,'r46-Cornfield_IQ',250,0.5);