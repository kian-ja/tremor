clear
load representativeData2R
close all
clc

windowStart = 52100;
windowEnd = windowStart + 999;
time = 0 : 0.001: 1-0.001;
figure
subplot(1,2,1)
plot(time,torque_DF(windowStart:windowEnd)*100)
hold on
plot(time,torque_PF1(windowStart:windowEnd)*100+1,'k')
plot(time,torque_PF2(windowStart:windowEnd)*100+2 ,'r')

xlabel('Time (s)')
ylabel('Torque (%MVC)')
title('Torque')
annotation('textbox','String','(A)','LineStyle','none','Position',[0.13 0.42 0.2 0.5]);
box off
%%
subplot(2,2,2)
plot(F,torque_DF_Power,'b','lineWidth',1.5)
hold on
plot(F,torque_PF1_Power,'k','lineWidth',1.5)
plot(F,torque_PF2_Power,'r','lineWidth',1.5)
xlim([0,20])
ylim([0,6*(10^-8)])
ylabel('Power')
set(gca,'XTickLabel',[])
legend('DP','MP','PP')
title('Torque Power Spectrum')
annotation('textbox','String','(B)','LineStyle','none','Position',[0.57 0.42 0.7 0.5]);
box off
%%
subplot(2,2,4)
plot(F,EMG_DF_Coherence,'b','lineWidth',1.5)
hold on
plot(F,EMG_PF1_Coherence,'k','lineWidth',1.5)
plot(F,EMG_PF2_Coherence,'r','lineWidth',1.5)
xlim([0,20])
xlabel('Frequency (Hz)')
ylabel('Coherence')
title('EMG-Torque Coherence')
annotation('textbox','String','(C)','LineStyle','none','Position',[0.57 -0.05 0.7 0.5]);
box off