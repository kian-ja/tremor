
clear
load dataPValue2R
close all
clc
figure
subplot(2,1,1)
hold on
fill([0,0,25,25],[0,0.05,0.05,0],[225,225,225]/255)
plot(F,pValue_TQ_PF2_DF,'color','r','lineWidth',1,'marker'...
    ,'d','markerFaceColor','r');
plot(F,pValue_TQ_PF1_DF,'color','b','lineWidth',1,'marker'...
    ,'o','markerFaceColor','b');
plot(F,pValue_TQ_PF2_PF1,'--','color','k','lineWidth',2.5,...
    'marker','s','markerFaceColor','k');
xlim([0,20])
ylim([0,1])
legend('Significance Interval','Power_{PP}, Power_{DP}',...
    'Power_{MP}, Power_{DP}'...
    ,'Power_{PP}, Power_{MP}')
ylabel('P-Value')
set(gca,'XTickLabel',[])
title('Torque Tremor Power')
annotation('textbox','String','(A)','LineStyle','none','Position',[0.13 0.42 0.2 0.5]);
box off
subplot(2,1,2)



hold on
fill([0,0,25,25],[0,0.05,0.05,0],[225,225,225]/255)
plot(F,pValue_EMG_TQ_PF2_DF,'color','r','lineWidth',1,'marker'...
    ,'d','markerFaceColor','r');
plot(F,pValue_EMG_TQ_PF1_DF,'color','b','lineWidth',1,'marker'...
    ,'o','markerFaceColor','b');
plot(F,pValue_EMG_TQ_PF2_PF1,'--','color','k','lineWidth',2.5,...
    'marker','s','markerFaceColor','k');
xlim([0,20])
ylim([0,1])
xlabel('Frequency (Hz)')
ylabel('P-Value')
title('EMG-Torque Tremor Coherence Area')
annotation('textbox','String','(B)','LineStyle','none','Position',[0.13 -0.05 0.2 0.5]);
box off
save dataPValue2R