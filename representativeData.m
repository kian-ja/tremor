clear
clc
close all
load experimentTrials
subject = 4;

torque = flbReadTorque(experiment.fileName{subject},experiment.DF.MVC{subject});
MVC_DF = min(torque);
torque = flbReadTorque(experiment.fileName{subject},experiment.DF.Passive{subject});
passive_DF = mean(torque);
MVC_DF = MVC_DF - passive_DF;
torque_DF = concatenateTorqueMultipleTrials(experiment.fileName{subject},experiment.DF.Trials{subject});
torque_DF = torque_DF - passive_DF;
torque_DF = torque_DF / MVC_DF;
torque_DF = torque_DF - mean(torque_DF);
EMG_DF = concatenateEMGMultipleTrials(experiment.fileName{subject},experiment.DF.Trials{subject});

torque = flbReadTorque(experiment.fileName{subject},experiment.PF1.MVC{subject});
MVC_PF1 = min(torque);
torque = flbReadTorque(experiment.fileName{subject},experiment.PF1.Passive{subject});
passive_PF1 = mean(torque);
MVC_PF1 = MVC_PF1 - passive_PF1;
torque_PF1 = concatenateTorqueMultipleTrials(experiment.fileName{subject},experiment.PF1.Trials{subject});
torque_PF1 = torque_PF1 - passive_PF1;
torque_PF1 = torque_PF1 / MVC_PF1;
torque_PF1 = torque_PF1 - mean(torque_PF1);
EMG_PF1 = concatenateEMGMultipleTrials(experiment.fileName{subject},experiment.PF1.Trials{subject});


torque = flbReadTorque(experiment.fileName{subject},experiment.PF2.MVC{subject});
MVC_PF2 = min(torque);
torque = flbReadTorque(experiment.fileName{subject},experiment.PF2.Passive{subject});
passive_PF2 = mean(torque);
MVC_PF2 = MVC_PF2 - passive_PF2;
torque_PF2 = concatenateTorqueMultipleTrials(experiment.fileName{subject},experiment.PF2.Trials{subject});
torque_PF2 = torque_PF2 - passive_PF2;
torque_PF2 = torque_PF2 / MVC_PF2;
torque_PF2 = torque_PF2 - mean(torque_PF2);
EMG_PF2 = concatenateEMGMultipleTrials(experiment.fileName{subject},experiment.PF2.Trials{subject});

%%
windowStart = 52100;
windowEnd = windowStart + 999;
time = 0 : 0.001: 1-0.001;
figure
subplot(1,2,1)
plot(time,torque_DF(windowStart:windowEnd)*100)
hold on
plot(time,torque_PF1(windowStart:windowEnd)*100+1,'k')
plot(time,torque_PF2(windowStart:windowEnd)*100+2 ,'r')
legend('DF','PF1','PF2')
xlabel('Time (s)')
ylabel('Torque (%MVC)')
title('Torque')
box off
%%
normalize = false;
[torque_DF_Power] = powerSignal(torque_DF,normalize);
[torque_PF1_Power] = powerSignal(torque_PF1,normalize);
[torque_PF2_Power,F] = powerSignal(torque_PF2,normalize);
subplot(2,2,2)
plot(F,torque_DF_Power)
hold on
plot(F,torque_PF1_Power,'k')
plot(F,torque_PF2_Power,'r')
xlim([0,20])
ylim([0,6*(10^-8)])
ylabel('Power')
set(gca,'XTickLabel',[])
title('Torque Power Spectrum')
box off
%%
subplot(2,2,4)
[EMG_DF_Coherence] = coherence_EMG_Torque(EMG_DF(:,2),torque_DF,false);
[EMG_PF1_Coherence] = coherence_EMG_Torque(EMG_PF1(:,2),torque_PF1,false);
[EMG_PF2_Coherence,F] = coherence_EMG_Torque(EMG_PF2(:,2),torque_PF2,false);
plot(F,EMG_DF_Coherence)
hold on
plot(F,EMG_PF1_Coherence,'k')
plot(F,EMG_PF2_Coherence,'r')
xlim([0,20])
xlabel('Frequency (Hz)')
ylabel('Coherence')
title('EMG-Torque Coherence')
box off
