function emg = concatenateEMGTAMultipleTrials(fileName,trials)
emg = [];
for i = 1 : length(trials)
	data = flb2mat(fileName,'read_case',trials(i));
	data = data.Data;
    emg = [emg;abs(data(:,6))];
end
end