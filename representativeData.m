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
subplot(3,1,1)
plot(time,torque_DF(windowStart:windowEnd)*100)
hold on
plot(time,torque_PF1(windowStart:windowEnd)*100+1,'k')
plot(time,torque_PF2(windowStart:windowEnd)*100+2 ,'r')
legend('DF','PF1','PF2')
xlabel('Time (s)')
ylabel('Torque (%MVC)')
box off
%%