function torque = concatenateTorqueMultipleTrials(fileName,trials)
torque = [];
for i = 1 : length(trials);
	data = flb2mat(fileName,'read_case',trials(i));
	data = data.Data;
	torque = [torque;data(:,2)];
end
end