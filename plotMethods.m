clear
clc
close all
load experimentTrials
load results/resultsNormalizedHPF
F = resultsNormalizedHPF.F;
subjectNumber = 3;
%MVC is the minimum of torque because it PF torque is negative by convention
%frequencyBands = [6 ; 12];
frequencyBands = [5 ; 12];
normalize = false;
[filterB,filterA] = butter(6,5/(1000/2),'high');
figure
freqz(filterB,filterA)

torque = flbReadTorque(experiment.fileName{subjectNumber},experiment.DF.MVC{subjectNumber});
MVC_DF = min(torque);
torque = flbReadTorque(experiment.fileName{subjectNumber},experiment.DF.Passive{subjectNumber});
passive_DF = mean(torque);
MVC_DF = MVC_DF - passive_DF;
torque_DF = concatenateTorqueMultipleTrials(experiment.fileName{subjectNumber},experiment.DF.Trials{subjectNumber});
torque_DF = torque_DF - passive_DF;
torque_DF = torque_DF / MVC_DF;
torque_DFFiltered = filtfilt(filterB,filterA,torque_DF);

torque = flbReadTorque(experiment.fileName{subjectNumber},experiment.PF1.MVC{subjectNumber});
MVC_PF1 = min(torque);
torque = flbReadTorque(experiment.fileName{subjectNumber},experiment.PF1.Passive{subjectNumber});
passive_PF1 = mean(torque);
MVC_PF1 = MVC_PF1 - passive_PF1;
torque_PF1 = concatenateTorqueMultipleTrials(experiment.fileName{subjectNumber},experiment.PF1.Trials{subjectNumber});
torque_PF1 = torque_PF1 - passive_PF1;
torque_PF1 = torque_PF1 / MVC_PF1;
torque_PF1Filtered = filtfilt(filterB,filterA,torque_PF1);

torque = flbReadTorque(experiment.fileName{subjectNumber},experiment.PF2.MVC{subjectNumber});
MVC_PF2 = min(torque);
torque = flbReadTorque(experiment.fileName{subjectNumber},experiment.PF2.Passive{subjectNumber});
passive_PF2 = mean(torque);
MVC_PF2 = MVC_PF2 - passive_PF2;
torque_PF2 = concatenateTorqueMultipleTrials(experiment.fileName{subjectNumber},experiment.PF2.Trials{subjectNumber});
torque_PF2 = torque_PF2 - passive_PF2;
torque_PF2 = torque_PF2 / MVC_PF2;
torque_PF2Filtered = filtfilt(filterB,filterA,torque_PF2);


windowStart = 86500;%52100;
windowEnd = windowStart + 999;
time = 0 : 0.001: 1-0.001;
figure
subplot(1,4,1)
plot(time,torque_DF(windowStart:windowEnd)*100-1.5)
hold on
plot(time,torque_PF1(windowStart:windowEnd)*100+1.5,'k')
plot(time,torque_PF2(windowStart:windowEnd)*100+1. ,'r')
% plot(torque_DF*100)
% hold on
% plot(torque_PF1*100+1,'k')
% plot(torque_PF2*100+2 ,'r')
ylim([27.5,30.5])
xlabel('Time (s)')
ylabel('Torque (%MVC)')
title('Torque')
box off
subplot(1,4,2)
plot(time,torque_DFFiltered(windowStart:windowEnd)*100)
hold on
plot(time,torque_PF1Filtered(windowStart:windowEnd)*100+1,'k')
plot(time,torque_PF2Filtered(windowStart:windowEnd)*100+1.75 ,'r')

% plot(torque_DFFiltered*100)
% hold on
% plot(torque_PF1Filtered*100+0.5,'k')
% plot(torque_PF2Filtered*100+1 ,'r')
ylim([-0.5,2.5])
xlabel('Time (s)')
box off
[torque_DF_Power,F] = powerSignal(torque_DFFiltered,0);
torque_PF1_Power = powerSignal(torque_PF1Filtered,0);
torque_PF2_Power = powerSignal(torque_PF2Filtered,0);
subplot(1,4,3)
plot(F,torque_DF_Power,'lineWidth',2)
hold on
plot(F,torque_PF1_Power,'k','lineWidth',2)
plot(F,torque_PF2_Power,'r','lineWidth',2)
xlim([0,20])
box off
%%
EMG_DF = concatenateEMGMultipleTrials(experiment.fileName{subjectNumber},experiment.DF.Trials{subjectNumber});
if subjectNumber == 1 
    EMG_DF = [EMG_DF(:,2) EMG_DF(:,1) EMG_DF(:,3)];
end
EMG_DF = EMG_DF(:,1);
[EMG_DF_Coherence,F_EMG] = coherence_EMG_Torque(EMG_DF,torque_DF,F);

EMG_PF1 = concatenateEMGMultipleTrials(experiment.fileName{subjectNumber},experiment.PF1.Trials{subjectNumber});
if subjectNumber == 1 
        EMG_PF1 = [EMG_PF1(:,2) EMG_PF1(:,1) EMG_PF1(:,3)];
end
EMG_PF1 = EMG_PF1(:,1);
[EMG_PF1_Coherence,F_EMG] = coherence_EMG_Torque(EMG_PF1,torque_PF1,F);

EMG_PF2 = concatenateEMGMultipleTrials(experiment.fileName{subjectNumber},experiment.PF2.Trials{subjectNumber});
if subjectNumber == 1 
        EMG_PF2 = [EMG_PF2(:,2) EMG_PF2(:,1) EMG_PF2(:,3)];
end
EMG_PF2 = EMG_PF2(:,1);
[EMG_PF2_Coherence,F_EMG] = coherence_EMG_Torque(EMG_PF2,torque_PF2,F);

% figure
% subplot(2,2,1)
% plot(time,EMG_DF(windowStart:windowEnd)*100)
% hold on
% plot(time,EMG_PF1(windowStart:windowEnd)*100+2,'k')
% plot(time,EMG_PF2(windowStart:windowEnd)*100+5 ,'r')
% subplot(2,2,3)
% plot(time,torque_DFFiltered(windowStart:windowEnd)*100)
% hold on
% plot(time,torque_PF1Filtered(windowStart:windowEnd)*100+0.75,'k')
% plot(time,torque_PF2Filtered(windowStart:windowEnd)*100+1.5 ,'r')

subplot(1,4,4)
plot(F_EMG,EMG_DF_Coherence,'lineWidth',2)
hold on
plot(F_EMG,EMG_PF1_Coherence,'k','lineWidth',2)
plot(F_EMG,EMG_PF2_Coherence,'r','lineWidth',2)
xlim([0,20])
box off
