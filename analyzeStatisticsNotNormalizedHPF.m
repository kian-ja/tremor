clear
clc
close all
load experimentTrials
numSubjects = length(experiment.fileName);
%MVC is the minimum of torque because it PF torque is negative by convention
frequencyBands = [5 ; 12];
normalize = false;
h = waitbar(0,'Please wait...');
for i = 1 : numSubjects
	waitbar(i / numSubjects)

    disp(['analyzing subject ',num2str(i),' out of ',num2str(numSubjects)])
    torque = flbReadTorque(experiment.fileName{i},experiment.DF.MVC{i});
    MVC_DF = min(torque);
    torque = flbReadTorque(experiment.fileName{i},experiment.DF.Passive{i});
    passive_DF = mean(torque);
    MVC_DF = MVC_DF - passive_DF;
    torque_DF = concatenateTorqueMultipleTrials(experiment.fileName{i},experiment.DF.Trials{i});
    torque_DF = torque_DF - passive_DF;
    torque_DF = torque_DF / MVC_DF;
    [torque_DF_Power,F] = powerSignal(torque_DF,normalize);
    powerFreqBand_DF = powerFreqBand(torque_DF_Power,F,frequencyBands,normalize);
    EMG_DF = concatenateEMGMultipleTrials(experiment.fileName{i},experiment.DF.Trials{i});
    if i == 1 
        EMG_DF = [EMG_DF(:,2) EMG_DF(:,1) EMG_DF(:,3)];
    end
    [EMG_DF_Coherence,F_EMG] = coherence_EMG_Torque(EMG_DF,torque_DF,F);
    EMG_DF_CoherenceFreqBand = powerFreqBand(EMG_DF_Coherence,F_EMG,frequencyBands,true);
    Results.DF.EMGCoherence{i} = EMG_DF_Coherence;
    Results.DF.EMGCoherenceFreqBand{i} = EMG_DF_CoherenceFreqBand;    
    Results.DF.powertorque(:,i) = torque_DF_Power;
    Results.DF.powerFreqBand(:,i) = powerFreqBand_DF;
    Results.DF.EMG_RMSr{i} = sqrt(sum(EMG_DF.^2)/size(EMG_DF,1));
    
    Results.F = F;
    Results.F_EMG = F_EMG;
    
    torque = flbReadTorque(experiment.fileName{i},experiment.PF1.MVC{i});
    MVC_PF1 = min(torque);
    torque = flbReadTorque(experiment.fileName{i},experiment.PF1.Passive{i});
    passive_PF1 = mean(torque);
    MVC_PF1 = MVC_PF1 - passive_PF1;
    torque_PF1 = concatenateTorqueMultipleTrials(experiment.fileName{i},experiment.PF1.Trials{i});
    torque_PF1 = torque_PF1 - passive_PF1;
    torque_PF1 = torque_PF1 / MVC_PF1;
    torque_PF1_Power = powerSignal(torque_PF1,normalize);
    powerFreqBand_PF1 = powerFreqBand(torque_PF1_Power,F,frequencyBands,normalize);
    EMG_PF1 = concatenateEMGMultipleTrials(experiment.fileName{i},experiment.PF1.Trials{i});
    if i == 1 
        EMG_PF1 = [EMG_PF1(:,2) EMG_PF1(:,1) EMG_PF1(:,3)];
    end
    [EMG_PF1_Coherence,F_EMG] = coherence_EMG_Torque(EMG_PF1,torque_PF1,F);
    EMG_PF1_CoherenceFreqBand = powerFreqBand(EMG_PF1_Coherence,F_EMG,frequencyBands,true);
    Results.PF1.EMGCoherence{i} = EMG_PF1_Coherence;
    Results.PF1.EMGCoherenceFreqBand{i} = EMG_PF1_CoherenceFreqBand;   
    Results.PF1.powertorque(:,i) = torque_PF1_Power;
    Results.PF1.powerFreqBand(:,i) = powerFreqBand_PF1;
    Results.PF1.EMG_RMSr{i} = sqrt(sum(EMG_PF1.^2)/size(EMG_PF1,1));

    
    
    torque = flbReadTorque(experiment.fileName{i},experiment.PF2.MVC{i});
    MVC_PF2 = min(torque);
    torque = flbReadTorque(experiment.fileName{i},experiment.PF2.Passive{i});
    passive_PF2 = mean(torque);
    MVC_PF2 = MVC_PF2 - passive_PF2;
    torque_PF2 = concatenateTorqueMultipleTrials(experiment.fileName{i},experiment.PF2.Trials{i});
    torque_PF2 = torque_PF2 - passive_PF2;
    torque_PF2 = torque_PF2 / MVC_PF2;
    torque_PF2_Power = powerSignal(torque_PF2,normalize);
    powerFreqBand_PF2 = powerFreqBand(torque_PF2_Power,F,frequencyBands,normalize);
    EMG_PF2 = concatenateEMGMultipleTrials(experiment.fileName{i},experiment.PF2.Trials{i});
    if i == 1 
        EMG_PF2 = [EMG_PF2(:,2) EMG_PF2(:,1) EMG_PF2(:,3)];
    end
    [EMG_PF2_Coherence,F_EMG] = coherence_EMG_Torque(EMG_PF2,torque_PF2,F);
    EMG_PF2_CoherenceFreqBand = powerFreqBand(EMG_PF2_Coherence,F_EMG,frequencyBands,true);
    Results.PF2.EMGCoherence{i} = EMG_PF2_Coherence;
    Results.PF2.EMGCoherenceFreqBand{i} = EMG_PF2_CoherenceFreqBand;
    Results.PF2.powertorque(:,i) = torque_PF2_Power;
    Results.PF2.powerFreqBand(:,i) = powerFreqBand_PF2;
    Results.PF2.EMG_RMSr{i} = sqrt(sum(EMG_PF2.^2)/size(EMG_PF2,1));
    
end
%%
close(h)
resultsNotNormalizedHPF = Results;
save results/resultsNotNormalizedHPF resultsNotNormalizedHPF;