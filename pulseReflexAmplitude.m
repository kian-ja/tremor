function reflexAmplitude = pulseReflexAmplitude(position,torque,threshold,reflexAmplitude)
positionDiff = diff(position);
positionDiff = max(positionDiff,0);
largeVelocityIndex = find(positionDiff>threshold);
largeVelocityIndexDiff = diff(largeVelocityIndex);
falseJumpIndex = find(largeVelocityIndexDiff == 1);
falseJumpIndex = falseJumpIndex + 1;
largeVelocityIndex(falseJumpIndex) = [];
reflexOnsetIndex = largeVelocityIndex + 40;
reflexEndIndex = largeVelocityIndex + 640;
numPulses = length(reflexOnsetIndex);
reflexAmplitudeThisTrial = zeros(numPulses,1);
figure(1000)
time = 1 : length(position);
time = time * 0.001;
plot(time,torque)
hold on
for i = 1 : numPulses
     response = torque(reflexOnsetIndex(i):reflexEndIndex(i));
     plot(time(reflexOnsetIndex(i):reflexEndIndex(i)),torque(reflexOnsetIndex(i):reflexEndIndex(i)),'o')
     responseSteadyState = mean(response(400:end));
     response = response - responseSteadyState;
     reflexAmplitudeThisTrial(i) = sqrt(sum(response.^2)/length(response));
end
pause
close(1000)
reflexAmplitude = [reflexAmplitude;reflexAmplitudeThisTrial];