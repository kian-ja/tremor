clear
close all

load results/resultsNormalized
load experimentTrials
load results/resultsNotNormalized
load experimentTrials
numSubjects = length(experiment.fileName);
subjectName = createSubjectName('S',numSubjects);

%%
figure
subplot(3,1,1)
b = bar(100*[resultsNotNormalized.DF.powerFreqBand(1,:);resultsNotNormalized.PF1.powerFreqBand(1,:);resultsNotNormalized.PF2.powerFreqBand(1,:)]');
set(b(1),'FaceColor','b');
set(b(2),'FaceColor','k');
set(b(3),'FaceColor','r');
legend('DP','MP','PP')
ylabel('Power')
title('Total Torque Power')
set(gca,'XTickLabel',[])
annotation('textbox','String','(A)','LineStyle','none','Position',[0.13 0.42 0.2 0.5]);
box off
subplot(3,1,2)
b = bar(100*[resultsNormalized.DF.powerFreqBand(3,:);resultsNormalized.PF1.powerFreqBand(3,:);resultsNormalized.PF2.powerFreqBand(3,:)]');
set(b(1),'FaceColor','b');
set(b(2),'FaceColor','k');
set(b(3),'FaceColor','r');
title('Torque Power in Tremor Range')
ylabel('Precentage of total power')
set(gca,'XTickLabel',[])
annotation('textbox','String','(B)','LineStyle','none','Position',[0.13 0.32 0.2 0.3]);
box off
subplot(3,1,3)

coherenceTremorPower_GM_TorqueDF = zeros(numSubjects,1);
coherenceTremorPower_GM_TorquePF1 = zeros(numSubjects,1);
coherenceTremorPower_GM_TorquePF2 = zeros(numSubjects,1);

for i = 1 : numSubjects
    coherenceTremorPower_GM_TorqueDF(i) = resultsNotNormalized.DF.EMGCoherenceFreqBand{i}(3,1);
    coherenceTremorPower_GM_TorquePF1(i) = resultsNotNormalized.PF1.EMGCoherenceFreqBand{i}(3,1);
    coherenceTremorPower_GM_TorquePF2(i) = resultsNotNormalized.PF2.EMGCoherenceFreqBand{i}(3,1);
end
b = bar(100*[coherenceTremorPower_GM_TorqueDF coherenceTremorPower_GM_TorquePF1 coherenceTremorPower_GM_TorquePF2]);
set(b(1),'FaceColor','b');
set(b(2),'FaceColor','k');
set(b(3),'FaceColor','r');
ylabel('Precentage of total area')
set(gca,'XTickLabel',subjectName)
xlabel('Subject number')
title('EMG-Torque Coherence Area in Tremor Range')
annotation('textbox','String','(C)','LineStyle','none','Position',[0.13 0.02 0.2 0.3]);
box off
saveas(gcf,'/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Analysis and Results/totalTremorPowerPosition.pdf')
totalPowerNotNormalizedDF = resultsNotNormalized.DF.powerFreqBand;
totalPowerNotNormalizedPF1 = resultsNotNormalized.PF1.powerFreqBand;
totalPowerNotNormalizedPF2 = resultsNotNormalized.PF2.powerFreqBand;


totalPowerNormalizedDF = resultsNormalized.DF.powerFreqBand;
totalPowerNormalizedPF1 = resultsNormalized.PF1.powerFreqBand;
totalPowerNormalizedPF2 = resultsNormalized.PF2.powerFreqBand;

save dataGroupResults2R totalPowerNotNormalizedDF totalPowerNotNormalizedPF1...
    totalPowerNotNormalizedPF2 coherenceTremorPower_GM_TorqueDF...
    coherenceTremorPower_GM_TorquePF1 coherenceTremorPower_GM_TorquePF2...
    subjectName totalPowerNormalizedDF totalPowerNormalizedPF1 totalPowerNormalizedPF2
%%

pValue_PF2_DF = pValueSign2Sided(resultsNormalized.PF2.powertorque,...
    resultsNormalized.DF.powertorque);
pValue_PF1_DF = pValueSign2Sided(resultsNormalized.PF1.powertorque,...
    resultsNormalized.DF.powertorque);
pValue_PF2_PF1 = pValueSign2Sided(resultsNormalized.PF2.powertorque,...
    resultsNormalized.PF1.powertorque);
pValue_TQ_PF2_DF = pValue_PF2_DF;
pValue_TQ_PF1_DF = pValue_PF1_DF;
pValue_TQ_PF2_PF1 = pValue_PF2_PF1;
figure
subplot(2,1,1)
hold on
fill([0,0,25,25],[0,0.05,0.05,0],[225,225,225]/255)
plot(resultsNormalized.F,pValue_PF2_DF,'color','r','lineWidth',1,'marker'...
    ,'d','markerFaceColor','r');
plot(resultsNormalized.F,pValue_PF1_DF,'color','b','lineWidth',1,'marker'...
    ,'o','markerFaceColor','b');
plot(resultsNormalized.F,pValue_PF2_PF1,'--','color','k','lineWidth',2.5,...
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
signal1 = zeros(length(resultsNotNormalized.F_EMG),numSubjects);
signal2 = zeros(length(resultsNotNormalized.F_EMG),numSubjects);
for i = 1 : numSubjects
    signal1(:,i) = resultsNotNormalized.PF2.EMGCoherence{i}(:,1);
    signal2(:,i) = resultsNotNormalized.DF.EMGCoherence{i}(:,1);
end
pValue_PF2_DF = pValueSign2Sided(signal1,signal2);
signal1 = zeros(length(resultsNotNormalized.F_EMG),numSubjects);
signal2 = zeros(length(resultsNotNormalized.F_EMG),numSubjects);
for i = 1 : numSubjects
    signal1(:,i) = resultsNotNormalized.PF1.EMGCoherence{i}(:,1);
    signal2(:,i) = resultsNotNormalized.DF.EMGCoherence{i}(:,1);
end
pValue_PF1_DF = pValueSign2Sided(signal1,signal2);

signal1 = zeros(length(resultsNotNormalized.F_EMG),numSubjects);
signal2 = zeros(length(resultsNotNormalized.F_EMG),numSubjects);
for i = 1 : numSubjects
    signal1(:,i) = resultsNotNormalized.PF2.EMGCoherence{i}(:,1);
    signal2(:,i) = resultsNotNormalized.PF1.EMGCoherence{i}(:,1);
end
pValue_PF2_PF1 = pValueSign2Sided(signal1,signal2);
pValue_EMG_TQ_PF2_DF = pValue_PF2_DF;
pValue_EMG_TQ_PF1_DF = pValue_PF1_DF;
pValue_EMG_TQ_PF2_PF1 = pValue_PF2_PF1;

hold on
fill([0,0,25,25],[0,0.05,0.05,0],[225,225,225]/255)
plot(resultsNormalized.F_EMG,pValue_PF2_DF,'color','r','lineWidth',1,'marker'...
    ,'d','markerFaceColor','r');
plot(resultsNormalized.F_EMG,pValue_PF1_DF,'color','b','lineWidth',1,'marker'...
    ,'o','markerFaceColor','b');
plot(resultsNormalized.F_EMG,pValue_PF2_PF1,'--','color','k','lineWidth',2.5,...
    'marker','s','markerFaceColor','k');
xlim([0,20])
ylim([0,1])
xlabel('Frequency (Hz)')
ylabel('P-Value')
title('EMG-Torque Tremor Coherence Area')
annotation('textbox','String','(B)','LineStyle','none','Position',[0.13 -0.05 0.2 0.5]);
box off
saveas(gcf,'/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Analysis and Results/pValuePosition.pdf')
F = resultsNormalized.F;
save dataPValue2R pValue_TQ_PF2_DF pValue_TQ_PF1_DF pValue_TQ_PF2_PF1 F...
    pValue_EMG_TQ_PF2_DF pValue_EMG_TQ_PF1_DF pValue_EMG_TQ_PF2_PF1
%%
figure
coherenceTremorPower_GM_TorqueDF = zeros(numSubjects,1);
coherenceTremorPower_GL_TorqueDF = zeros(numSubjects,1);
coherenceTremorPower_Sol_TorqueDF = zeros(numSubjects,1);

coherenceTremorPower_GM_TorquePF1 = zeros(numSubjects,1);
coherenceTremorPower_GL_TorquePF1 = zeros(numSubjects,1);
coherenceTremorPower_Sol_TorquePF1 = zeros(numSubjects,1);

coherenceTremorPower_GM_TorquePF2 = zeros(numSubjects,1);
coherenceTremorPower_GL_TorquePF2 = zeros(numSubjects,1);
coherenceTremorPower_Sol_TorquePF2 = zeros(numSubjects,1);

for i = 1 : numSubjects
    coherenceTremorPower_GM_TorqueDF(i) = resultsNotNormalized.DF.EMGCoherenceFreqBand{i}(3,1);
    coherenceTremorPower_GL_TorqueDF(i) = resultsNotNormalized.DF.EMGCoherenceFreqBand{i}(3,2);
    coherenceTremorPower_Sol_TorqueDF(i) = resultsNotNormalized.DF.EMGCoherenceFreqBand{i}(3,3);
    
    coherenceTremorPower_GM_TorquePF1(i) = resultsNotNormalized.PF1.EMGCoherenceFreqBand{i}(3,1);
    coherenceTremorPower_GL_TorquePF1(i) = resultsNotNormalized.PF1.EMGCoherenceFreqBand{i}(3,2);
    coherenceTremorPower_Sol_TorquePF1(i) = resultsNotNormalized.PF1.EMGCoherenceFreqBand{i}(3,3);
    
    coherenceTremorPower_GM_TorquePF2(i) = resultsNotNormalized.PF2.EMGCoherenceFreqBand{i}(3,1);
    coherenceTremorPower_GL_TorquePF2(i) = resultsNotNormalized.PF2.EMGCoherenceFreqBand{i}(3,2);
    coherenceTremorPower_Sol_TorquePF2(i) = resultsNotNormalized.PF2.EMGCoherenceFreqBand{i}(3,3);
end
subplot(3,1,1)
bar(100*[coherenceTremorPower_GM_TorqueDF coherenceTremorPower_GM_TorquePF1 coherenceTremorPower_GM_TorquePF2])
legend('DP','MP','PP')
ylabel('%Power')
xlabel('Subject number')
title('Tremor Power Gastrocnemius Medialis-Torque Coherence')
box off

subplot(3,1,2)
bar(100*[coherenceTremorPower_GL_TorqueDF coherenceTremorPower_GL_TorquePF1 coherenceTremorPower_GL_TorquePF2])
legend('DP','MP','PP')
ylabel('%Power')
xlabel('Subject number')
title('Tremor Power Gastrocnemius Lateralis-Torque Coherence')
box off

subplot(3,1,3)
bar(100*[coherenceTremorPower_Sol_TorqueDF coherenceTremorPower_Sol_TorquePF1 coherenceTremorPower_Sol_TorquePF2])
ylabel('%Power')
xlabel('Subject number')
title('Tremor Power Soleus-Torque Coherence')
legend('DP','MP','PP')
box off
saveas(gcf,'/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Analysis and Results/EMGTremorPowerPosition.pdf')

