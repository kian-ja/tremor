load stretchReflexTrials
numSubject = length(experiment.PF2.MVC{1});
for i = 1 : numSubject
    pulseTrials = experiment.DF.pulseTrials{i};
    reflexAmplitude = [];
    for j = 1 : length(pulseTrials)
        position = flbReadDesiredPosition(experiment.fileName{i},pulseTrials(j));
        torque = flbReadTorque(experiment.fileName{i},pulseTrials(j));
        reflexAmplitude = pulseReflexAmplitude(position,torque,0.01,reflexAmplitude); 
    end
    results.DF.pulseReflexAmplitude.mean = mean(reflexAmplitude);
    results.DF.pulseReflexAmplitude.std = std(reflexAmplitude);
    
    
    pulseTrials = experiment.PF1.pulseTrials{i};
    reflexAmplitude = [];
    for j = 1 : length(pulseTrials)
        position = flbReadDesiredPosition(experiment.fileName{i},pulseTrials(j));
        torque = flbReadTorque(experiment.fileName{i},pulseTrials(j));
        reflexAmplitude = pulseReflexAmplitude(position,torque,0.01,reflexAmplitude); 
    end
    results.PF1.pulseReflexAmplitude.mean = mean(reflexAmplitude);
    results.PF1.pulseReflexAmplitude.std = std(reflexAmplitude);
    
    
    pulseTrials = experiment.PF2.pulseTrials{i};
    reflexAmplitude = [];
    for j = 1 : length(pulseTrials)
        position = flbReadDesiredPosition(experiment.fileName{i},pulseTrials(j));
        torque = flbReadTorque(experiment.fileName{i},pulseTrials(j));
        reflexAmplitude = pulseReflexAmplitude(position,torque,0.01,reflexAmplitude); 
    end
    results.PF2.pulseReflexAmplitude.mean = mean(reflexAmplitude);
    results.PF2.pulseReflexAmplitude.std = std(reflexAmplitude);
end
save stretchReflexResults results