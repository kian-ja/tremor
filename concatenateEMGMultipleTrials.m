function emg = concatenateEMGMultipleTrials(fileName,trials)
emg = [];
for i = 1 : length(trials)
	data = flb2mat(fileName,'read_case',trials(i));
	data = data.Data;
    emg = [emg;abs(data(:,4)),abs(data(:,5)),abs(data(:,7))];
end
emg = emg - mean(emg);
end