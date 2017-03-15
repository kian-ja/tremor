function [CC,F] = coherence_EMG_Torque(EMG,torque,F,zTransform)
%% parameters
if (nargin == 3)
    zTransform = true;
end
fs = 1000;
frequency = 0 : 1: fs/2;
overLap = 500;%3500;%1000
windowLength = 1000;%5000;%5000
%% Main function
num_EMG_channel = size(EMG,2);
CC = zeros(length(F),num_EMG_channel);
for i = 1 : num_EMG_channel
    %[CC(:,i),F] = mscohere(EMG(:,i),torque,gausswin(windowLength),overLap,frequency,fs);
    [CC(:,i),F] = mscohere(EMG(:,i),torque,rectwin(windowLength),overLap,frequency,fs);
    if zTransform
        CC(:,i) = atanh(sqrt(CC(:,i)));
    end
end

end