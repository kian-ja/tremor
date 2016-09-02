load stretchReflexTrials
numSubject = length(experiment.PF2.MVC{1});
normalize = true;
pulseTrials = experiment.DF.pulseTrials{1};
position = flbReadMeasuredPosition(experiment.fileName{1},pulseTrials(1));
positionUpSample = resample(position,10,1);
positionUpSample = nldat(positionUpSample,'domainIncr',0.0001);
velocityUpSample = ddt(positionUpSample);
accelerationUpSample = ddt(velocityUpSample);
positionUpSample = positionUpSample.dataSet;
velocityUpSample = velocityUpSample.dataSet;
accelerationUpSample = accelerationUpSample.dataSet;
[b,a] = butter(4,0.05);
positionUpSample = filter(b,a,positionUpSample);
velocityUpSample = filter(b,a,velocityUpSample);
accelerationUpSample = filter(b,a,accelerationUpSample);
positionUpSample = positionUpSample (100:50000+99);
velocityUpSample = velocityUpSample (100:50000+99);
accelerationUpSample = accelerationUpSample (100:50000+99);
figure
subplot(3,1,1)
plot(positionUpSample)
subplot(3,1,2)
plot(velocityUpSample)
subplot(3,1,3)
plot(accelerationUpSample)
save pulsePerturbation positionUpSample velocityUpSample accelerationUpSample



