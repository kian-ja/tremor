load results/resultsNormalizedHPF

rmsValueEMGChannel = zeros(21,3);
for i = 1 : 7
	rmsValueEMGChannel(i,1) = resultsNormalizedHPF.DF.EMG_RMS{i}(1);
    rmsValueEMGChannel(i,2) = resultsNormalizedHPF.PF1.EMG_RMS{i}(1);
    rmsValueEMGChannel(i,3) = resultsNormalizedHPF.PF2.EMG_RMS{i}(1);
end

for i = 8 : 14
	rmsValueEMGChannel(i,1) = resultsNormalizedHPF.DF.EMG_RMS{i-7}(2);
    rmsValueEMGChannel(i,2) = resultsNormalizedHPF.PF1.EMG_RMS{i-7}(2);
    rmsValueEMGChannel(i,3) = resultsNormalizedHPF.PF2.EMG_RMS{i-7}(2);
end

for i = 15 : 21
	rmsValueEMGChannel(i,1) = resultsNormalizedHPF.DF.EMG_RMS{i-14}(3);
    rmsValueEMGChannel(i,2) = resultsNormalizedHPF.PF1.EMG_RMS{i-14}(3);
    rmsValueEMGChannel(i,3) = resultsNormalizedHPF.PF2.EMG_RMS{i-14}(3);
end
%%
figure
boxplot(rmsValueEMGChannel)

figure
bar(rmsValueEMGChannel)
