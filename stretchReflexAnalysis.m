load stretchReflexTrials
numSubject = length(experiment.PF2.MVC{1});
frequencyBands = [1; 5; 6; 12];
normalize = true;

for i = 1 : numSubject
    pulseTrials = experiment.DF.pulseTrials{i};
    reflexAmplitude = [];
    for j = 1 : length(pulseTrials)
        position = flbReadDesiredPosition(experiment.fileName{i},pulseTrials(j));
        torque = flbReadTorque(experiment.fileName{i},pulseTrials(j));
        reflexAmplitude = pulseReflexAmplitude(position,torque,0.01,reflexAmplitude); 
    end
    results.DF.pulseReflexAmplitude = reflexAmplitude;
    torque = flbReadTorque(experiment.fileName{i},experiment.DF.MVC{i});
    MVC_DF = min(torque);
    torque = flbReadTorque(experiment.fileName{i},experiment.DF.Passive{i});
    passive_DF = mean(torque);
    MVC_DF = MVC_DF - passive_DF;
    torque_DF = concatenateTorqueMultipleTrials(experiment.fileName{i},experiment.DF.isometricTrials{i});
    torque_DF = torque_DF - passive_DF;
    torque_DF = torque_DF / MVC_DF;
    [torque_DF_Power,F] = powerSignal(torque_DF,normalize);
    powerFreqBand_DF = powerFreqBand(torque_DF_Power,F,frequencyBands,normalize);
    Results.DF.powertorque(:,i) = torque_DF_Power;
    Results.DF.powerFreqBand(:,i) = powerFreqBand_DF;
    Results.F = F;
    
    
    pulseTrials = experiment.PF1.pulseTrials{i};
    reflexAmplitude = [];
    for j = 1 : length(pulseTrials)
        position = flbReadDesiredPosition(experiment.fileName{i},pulseTrials(j));
        torque = flbReadTorque(experiment.fileName{i},pulseTrials(j));
        reflexAmplitude = pulseReflexAmplitude(position,torque,0.01,reflexAmplitude); 
    end
    results.PF1.pulseReflexAmplitude = reflexAmplitude;
    
    torque = flbReadTorque(experiment.fileName{i},experiment.PF1.MVC{i});
    MVC_PF1 = min(torque);
    torque = flbReadTorque(experiment.fileName{i},experiment.PF1.Passive{i});
    passive_PF1 = mean(torque);
    MVC_PF1 = MVC_PF1 - passive_PF1;
    torque_PF1 = concatenateTorqueMultipleTrials(experiment.fileName{i},experiment.PF1.isometricTrials{i});
    torque_PF1 = torque_PF1 - passive_PF1;
    torque_PF1 = torque_PF1 / MVC_PF1;
    torque_PF1_Power = powerSignal(torque_PF1,normalize);
    powerFreqBand_PF1 = powerFreqBand(torque_PF1_Power,F,frequencyBands,normalize);
    Results.PF1.powertorque(:,i) = torque_PF1_Power;
    Results.PF1.powerFreqBand(:,i) = powerFreqBand_PF1;
    
    
    pulseTrials = experiment.PF2.pulseTrials{i};
    reflexAmplitude = [];
    for j = 1 : length(pulseTrials)
        position = flbReadDesiredPosition(experiment.fileName{i},pulseTrials(j));
        torque = flbReadTorque(experiment.fileName{i},pulseTrials(j));
        reflexAmplitude = pulseReflexAmplitude(position,torque,0.01,reflexAmplitude); 
    end
    results.PF2.pulseReflexAmplitude = reflexAmplitude;
    
    torque = flbReadTorque(experiment.fileName{i},experiment.PF2.MVC{i});
    MVC_PF2 = min(torque);
    torque = flbReadTorque(experiment.fileName{i},experiment.PF2.Passive{i});
    passive_PF2 = mean(torque);
    MVC_PF2 = MVC_PF2 - passive_PF2;
    torque_PF2 = concatenateTorqueMultipleTrials(experiment.fileName{i},experiment.PF2.isometricTrials{i});
    torque_PF2 = torque_PF2 - passive_PF2;
    torque_PF2 = torque_PF2 / MVC_PF2;
    torque_PF2_Power = powerSignal(torque_PF2,normalize);
    powerFreqBand_PF2 = powerFreqBand(torque_PF2_Power,F,frequencyBands,normalize);
    Results.PF2.powertorque(:,i) = torque_PF2_Power;
    Results.PF2.powerFreqBand(:,i) = powerFreqBand_PF2;
end
save stretchReflexResults results