
for i = 1 : 7
    figure
    EMG_PowerDF = Results.DF.EMG_RMSr{i};
    EMG_PowerPF1 = Results.PF1.EMG_RMSr{i};
    EMG_PowerPF2 = Results.PF2.EMG_RMSr{i};
    bar([EMG_PowerDF;EMG_PowerPF1;EMG_PowerPF2])
    labels = {'Plantarflexed position','Mid position','Dorsiflexed position'};
    set(gca,'XTickLabel',labels)
end 