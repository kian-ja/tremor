function position = flbReadMeasuredPosition(fileName, trialNumber)
    data = flb2mat(fileName,'read_case',trialNumber);
    data = data.Data;
    position = data(:,1);
end