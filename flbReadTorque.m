function torque = flbReadTorque(fileName, trialNumber)
    data = flb2mat(fileName,'read_case',trialNumber);
    data = data.Data;
    torque = data(:,2);
end