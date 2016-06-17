function [CC,F] = coherence_EMG_Torque(EMG,torque)
%% parameters
fs = 1000;
frequency = 0 : 1: fs/2;
overLap = 500;
windowLength = 1000;
%% Main function
num_EMG_channel = size(EMG,2);
CC = zeros(length(frequency),num_EMG_channel);
for i = 1 : num_EMG_channel
    [CC(:,i),F] = mscohere(EMG(:,i),torque,gausswin(windowLength),overLap,frequency,fs);
end

end