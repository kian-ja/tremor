function stiffness = pulseStiffnessAmplitude(position,torque,threshold,stiffnessValues)
positionDiff = diff(position);
positionDiff = max(positionDiff,0);
largeVelocityIndex = find(positionDiff>threshold);
largeVelocityIndexDiff = diff(largeVelocityIndex);
falseJumpIndex = find(largeVelocityIndexDiff == 1);
falseJumpIndex = falseJumpIndex + 1;
largeVelocityIndex(falseJumpIndex) = [];

stiffnessAfterPerturbationOnsetIndex = largeVelocityIndex + 600;
stiffnessAfterPerturbationEndIndex = largeVelocityIndex + 950;

stiffnessBeforePerturbationOnsetIndex = largeVelocityIndex - 1000;
stiffnessBeforePerturbationEndIndex = largeVelocityIndex-100;

elementIndex2Remove = find (stiffnessBeforePerturbationOnsetIndex<0);
stiffnessAfterPerturbationOnsetIndex(elementIndex2Remove) = [];
stiffnessAfterPerturbationEndIndex(elementIndex2Remove) = [];
stiffnessBeforePerturbationOnsetIndex(elementIndex2Remove) = [];
stiffnessBeforePerturbationEndIndex(elementIndex2Remove) = [];
numPulses = length(stiffnessAfterPerturbationOnsetIndex);
torqueAfterPerturbation = zeros(numPulses,1);
torqueBeforePerturbation = zeros(numPulses,1);
positionAfterPerturbation = zeros(numPulses,1);
positionBeforePerturbation = zeros(numPulses,1);
figure(1000)
time = 1 : length(position);
time = time * 0.001;
subplot(2,1,1)
plot(time,position)
subplot(2,1,2)
plot(time,torque)
hold on
for i = 1 : numPulses
     positionResponse = position(stiffnessAfterPerturbationOnsetIndex(i):stiffnessAfterPerturbationEndIndex(i));
     torqueResponse = torque(stiffnessAfterPerturbationOnsetIndex(i):stiffnessAfterPerturbationEndIndex(i));
     plot(time(stiffnessAfterPerturbationOnsetIndex(i):stiffnessAfterPerturbationEndIndex(i)),torque(stiffnessAfterPerturbationOnsetIndex(i):stiffnessAfterPerturbationEndIndex(i)),'o')
     torqueAfterPerturbation(i) = mean(torqueResponse(1:end));
     positionAfterPerturbation(i) = mean(positionResponse(1:end));
end
xAxisPanZoom
pause
close(1000)
figure(1000)
time = 1 : length(position);
time = time * 0.001;
subplot(2,1,1)
plot(time,position)
subplot(2,1,2)
plot(time,torque)
hold on
for i = 1 : numPulses
    positionResponse = position(stiffnessBeforePerturbationOnsetIndex(i):stiffnessBeforePerturbationEndIndex(i)); 
    torqueResponse = torque(stiffnessBeforePerturbationOnsetIndex(i):stiffnessBeforePerturbationEndIndex(i));
    plot(time(stiffnessBeforePerturbationOnsetIndex(i):stiffnessBeforePerturbationEndIndex(i)),torque(stiffnessBeforePerturbationOnsetIndex(i):stiffnessBeforePerturbationEndIndex(i)),'o')
    torqueBeforePerturbation(i) = mean(torqueResponse(1:end));
    positionBeforePerturbation(i) = mean(positionResponse(1:end));
end
xAxisPanZoom
pause
close(1000)

stiffnessValuesThisTrial = torqueAfterPerturbation - torqueBeforePerturbation;
posDiffThisTrial = positionAfterPerturbation - positionBeforePerturbation;
stiffnessValuesThisTrial = abs(stiffnessValuesThisTrial ./posDiffThisTrial);
stiffness = [stiffnessValues;stiffnessValuesThisTrial];