experiment.fileName{1} = '/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Data/MG_020816.flb';
experiment.DF.MVC{1} = 1;
experiment.DF.Passive{1} = 17;
experiment.DF.isometricTrials{1} = [18,19,20];
experiment.DF.pulseTrials{1} = [22,24];
experiment.DF.praldsTrials{1} = [21,23];

experiment.PF1.MVC{1} = 2;
experiment.PF1.Passive{1} = 4;
experiment.PF1.isometricTrials{1} = [5,6,7];
experiment.PF1.pulseTrials{1} = [9];
experiment.PF1.praldsTrials{1} = [8,10];

experiment.PF2.MVC{1} = 3;
experiment.PF2.Passive{1} = 11;
experiment.PF2.isometricTrials{1} = [12,13,14];
experiment.PF2.pulseTrials{1} = [16];
experiment.PF2.praldsTrials{1} = [15];
numSubject = length(experiment.PF2.MVC{1});
for i = 1 : numSubject
    numPulseTrials = length(experiment.DF.pulseTrials{i});
    for j = 1 : numPulseTrials
        
    end
end