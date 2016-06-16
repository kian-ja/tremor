clear
%load('subject_DLG_Results.mat')
load('subject_ES_Results.mat')
load('subject_IH_Results.mat')
load('subject_KJ_Results.mat')
load('subject_MG_Results.mat')
load('subject_MR_Results.mat')
load('subject_PA_Results.mat')
subjects = [ subject_ES_Results subject_IH_Results subject_KJ_Results...
    subject_MG_Results subject_MR_Results subject_PA_Results];
%subjectsNormalized = normalizeTremor(subjects);
subjectsNormalized = subjects;
tremorMeanPosition = zeros(3,length(subjectsNormalized));
tremorRangeLowPosition = zeros(3,length(subjectsNormalized));
tremorRangeHighPosition = zeros(3,length(subjectsNormalized));
tremorMeanContract = zeros(3,length(subjectsNormalized));
tremorRangeContract = zeros(3,length(subjectsNormalized));
for i = 1 : length(subjectsNormalized);
    subject = subjects(i);
    tremorPowerMean = mean([subject.DF.force.tremorPower subject.PF1.force.tremorPower subject.PF2.force.tremorPower]);
    tremorPowerLow = prctile([subject.DF.force.tremorPower subject.PF1.force.tremorPower subject.PF2.force.tremorPower],10);
    tremorPowerHigh = prctile([subject.DF.force.tremorPower subject.PF1.force.tremorPower subject.PF2.force.tremorPower],90);
    %tremorPowerStd = tremorPowerStd./tremorPowerMean(1);
    tremorPowerLow = tremorPowerLow./tremorPowerMean(1);
    tremorPowerHigh = tremorPowerHigh./tremorPowerMean(1);
    tremorPowerMean = tremorPowerMean./tremorPowerMean(1);
    tremorMeanPosition(:,i) = tremorPowerMean';
    
    tremorRangeLowPosition(:,i) = tremorPowerLow';
    tremorRangeHighPosition(:,i) = tremorPowerLow';
end
subjectNumber1 = 1:length(subjects);
subjectNumber2 = length(subjects)+2:2*length(subjects)+1;
subjectNumber3 = 2*length(subjects)+3:2*length(subjects)+length(subjects)+2;
figure
bar(subjectNumber1,tremorMeanPosition(1,:),'FaceColor',[224 224 224]/255);
hold on
errorbar(subjectNumber1,tremorMeanPosition(1,:),tremorRangeLowPosition(1,:)...
        ,tremorRangeHighPosition(1,:),'k','lineStyle','none')
bar(subjectNumber2,tremorMeanPosition(2,:),'FaceColor',[224 224 224]/255);
errorbar(subjectNumber2,tremorMeanPosition(2,:),tremorRangeLowPosition(2,:)...
        ,tremorRangeHighPosition(2,:),'k','lineStyle','none')
bar(subjectNumber3,tremorMeanPosition(3,:),'FaceColor',[224 224 224]/255);
errorbar(subjectNumber3,tremorMeanPosition(3,:),tremorRangeLowPosition(3,:)...
        ,tremorRangeHighPosition(3,:),'k','lineStyle','none')
%%
figure
hold on
for i = 1 : length(subjects)
    xAxis = [i-0.2 i i+0.2];
    bar(xAxis,tremorMeanPosition(:,i),'FaceColor',[224 224 224]/255,'barWidth',1)
    errorbar(xAxis,tremorMeanPosition(:,i),tremorRangeLowPosition(:,i)...
        ,tremorRangeHighPosition(:,i),'k','lineStyle','none')
end
%tremorGroupMean = mean(tremorMeanPosition,2);
%tremorGroupStd = [sqrt(sum(tremorStdPosition(1,:).^2));sqrt(sum(tremorStdPosition(2,:).^2));sqrt(sum(tremorStdPosition(3,:).^2))];
%figure
%bar(tremorGroupMean)
%hold on
%errorbar([1,2,3],tremorGroupMean,tremorGroupMean-tremorGroupStd,tremorGroupMean+tremorGroupStd)