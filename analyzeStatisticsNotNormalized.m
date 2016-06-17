load experimentTrials
numSubjects = length(experiment.fileName);
%MVC is the minimum of torque because it PF torque is negative by convention
frequencyBands = [6 ; 12];
normalize = false;
for i = 1 : numSubjects
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
    [EMG_DF_Coherence,F] = coherence_EMG_Torque(EMG_DF,torque_DF);
    EMG_DF_CoherenceFreqBand = powerFreqBand(EMG_DF_Coherence,F,frequencyBands,true);
    Results.DF.EMGCoherence(:,i) = EMG_DF_Coherence;
    Results.DF.EMGCoherenceFreqBand(:,i) = EMG_DF_CoherenceFreqBand;    
    Results.DF.powertorque(:,i) = torque_DF_Power;
    Results.DF.powerFreqBand(:,i) = powerFreqBand_DF;
    
    
    Results.F = F;
    
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
    [EMG_PF1_Coherence,F] = coherence_EMG_Torque(EMG_PF1,torque_PF1);
    EMG_PF1_CoherenceFreqBand = powerFreqBand(EMG_PF1_Coherence,F,frequencyBands,true);
    Results.PF1.EMGCoherence(:,i) = EMG_PF1_Coherence;
    Results.PF1.EMGCoherenceFreqBand(:,i) = EMG_PF1_CoherenceFreqBand;   
    Results.PF1.powertorque(:,i) = torque_PF1_Power;
    Results.PF1.powerFreqBand(:,i) = powerFreqBand_PF1;
    
    
    
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
    [EMG_PF2_Coherence,F] = coherence_EMG_Torque(EMG_PF2,torque_PF2);
    EMG_PF2_CoherenceFreqBand = powerFreqBand(EMG_PF2_Coherence,F,frequencyBands,true);
    Results.PF2.EMGCoherence(:,i) = EMG_PF2_Coherence;
    Results.PF2.EMGCoherenceFreqBand(:,i) = EMG_PF2_CoherenceFreqBand;
    Results.PF2.powertorque(:,i) = torque_PF2_Power;
    Results.PF2.powerFreqBand(:,i) = powerFreqBand_PF2;
    
    
    torque_PF2_MVC20 = concatenateTorqueMultipleTrials(experiment.fileName{i},experiment.PF2.MVC20.Trials{i});
    torque_PF2_MVC20 = torque_PF2_MVC20 - passive_PF2;
    torque_PF2_MVC20 = torque_PF2_MVC20 / MVC_PF2;
    torque_PF2_MVC20_Power = powerSignal(torque_PF2_MVC20,normalize);
    powerFreqBand_PF2_MVC20 = powerFreqBand(torque_PF2_MVC20_Power,F,frequencyBands,normalize);
    EMG_PF2_MVC20 = concatenateEMGMultipleTrials(experiment.fileName{i},experiment.PF2.MVC20.Trials{i});
    [EMG_PF2_MVC20_Coherence,F] = coherence_EMG_Torque(EMG_PF2_MVC20,torque_PF2_MVC20);
    EMG_PF2_MVC20_CoherenceFreqBand = powerFreqBand(EMG_PF2_MVC20_Coherence,F,frequencyBands,true);
    Results.PF2.MVC20.EMGCoherence(:,i) = EMG_PF2_MVC20_Coherence;
    Results.PF2.MVC20.EMGCoherenceFreqBand(:,i) = EMG_PF2_MVC20_CoherenceFreqBand;
    Results.PF2.MVC20.powertorque(:,i) = torque_PF2_MVC20_Power;
    Results.PF2.MVC20.powerFreqBand(:,i) = powerFreqBand_PF2_MVC20;
    
    torque_PF2_MVC30 = concatenateTorqueMultipleTrials(experiment.fileName{i},experiment.PF2.MVC30.Trials{i});
    torque_PF2_MVC30 = torque_PF2_MVC30 - passive_PF2;
    torque_PF2_MVC30 = torque_PF2_MVC30 / MVC_PF2;
    torque_PF2_MVC30_Power = powerSignal(torque_PF2_MVC30,normalize);
    powerFreqBand_PF2_MVC30 = powerFreqBand(torque_PF2_MVC30_Power,F,frequencyBands,normalize);
    EMG_PF2_MVC30 = concatenateEMGMultipleTrials(experiment.fileName{i},experiment.PF2.MVC30.Trials{i});
    [EMG_PF2_MVC30_Coherence,F] = coherence_EMG_Torque(EMG_PF2_MVC30,torque_PF2_MVC30);
    EMG_PF2_MVC30_CoherenceFreqBand = powerFreqBand(EMG_PF2_MVC30_Coherence,F,frequencyBands,true);
    Results.PF2.MVC30.EMGCoherence(:,i) = EMG_PF2_MVC30_Coherence;
    Results.PF2.MVC30.EMGCoherenceFreqBand(:,i) = EMG_PF2_MVC30_CoherenceFreqBand;
    Results.PF2.MVC30.powertorque(:,i) = torque_PF2_MVC30_Power;
    Results.PF2.MVC30.powerFreqBand(:,i) = powerFreqBand_PF2_MVC30;
    
    torque_PF2_MVC40 = concatenateTorqueMultipleTrials(experiment.fileName{i},experiment.PF2.MVC40.Trials{i});
    torque_PF2_MVC40 = torque_PF2_MVC40 - passive_PF2;
    torque_PF2_MVC40 = torque_PF2_MVC40 / MVC_PF2;
    [torque_PF2_MVC40_Power,F] = powerSignal(torque_PF2_MVC40,normalize);
    powerFreqBand_PF2_MVC40 = powerFreqBand(torque_PF2_MVC40_Power,F,frequencyBands,normalize);
    EMG_PF2_MVC40 = concatenateEMGMultipleTrials(experiment.fileName{i},experiment.PF2.MVC40.Trials{i});
    [EMG_PF2_MVC40_Coherence,F] = coherence_EMG_Torque(EMG_PF2_MVC40,torque_PF2_MVC40);
    EMG_PF2_MVC40_CoherenceFreqBand = powerFreqBand(EMG_PF2_MVC40_Coherence,F,frequencyBands,true);
    Results.PF2.MVC40.EMGCoherence(:,i) = EMG_PF2_MVC40_Coherence;
    Results.PF2.MVC40.EMGCoherenceFreqBand(:,i) = EMG_PF2_MVC40_CoherenceFreqBand;
    Results.PF2.MVC40.powertorque(:,i) = torque_PF2_MVC40_Power;
    Results.PF2.MVC40.powerFreqBand(:,i) = powerFreqBand_PF2_MVC40;
    
    Results.F = F;

end
%%
figure
bar(100*[Results.DF.powerFreqBand(1,:);Results.PF1.powerFreqBand(1,:);Results.PF2.powerFreqBand(1,:)]');
legend('DP','MP','PP')
ylabel('Power')
xlabel('Subject number')
title('Total Power')
box off
saveas(gcf,'/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Analysis and Results/totalPowerPosition.pdf')

%%
figure
bar(100*[Results.PF2.MVC20.powerFreqBand(1,:);Results.PF2.MVC30.powerFreqBand(1,:);Results.PF2.MVC40.powerFreqBand(1,:)]');
legend('20%','30%','40%')
ylabel('Power')
xlabel('Subject number')
title('Total Power')
box off
saveas(gcf,'/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Analysis and Results/totalPowerContraction.pdf')