function emg = flbReadEMG(fileName, trialNumber)
    data = flb2mat(fileName,'read_case',trialNumber);
    data = data.Data;
    emg = [abs(data(:,4))-mean(abs(data(:,4))),abs(data(:,5))-mean(abs(data(:,5))),abs(data(:,7))-mean(abs(data(:,7)))];
end