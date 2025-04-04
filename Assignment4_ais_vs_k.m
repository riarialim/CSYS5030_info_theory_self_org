% Add JIDT jar library to the path, and disable warnings that it's already there:
warning('off','MATLAB:Java:DuplicateClass');
javaaddpath('C:\Users\maria\OneDrive\Documents\infodynamics-dist-1.5\infodynamics.jar');
% Add utilities to the path
addpath('C:\Users\maria\OneDrive\Documents\infodynamics-dist-1.5\demos\octave');

data = load('C:\Users\maria\OneDrive\Documents\1USyd\2nd_sem\CSYS5030\assessment\Assignment3-4\bwv244_D_notes.csv');
% Column indices start from 1 in Matlab:
variable = octaveToJavaIntArray(data(:,4));

for k = 1:6
% 1. Construct the calculator:
calc = javaObject('infodynamics.measures.discrete.ActiveInformationCalculatorDiscrete', 14, k);
% 2. No other properties to set for discrete calculators.
% 3. Initialise the calculator for (re-)use:
calc.initialise();
% 4. Supply the sample data:
calc.addObservations(variable);
% 5. Compute the estimate:
result = calc.computeAverageLocalOfObservations();
results(k) = result;
% 6. Compute the (statistical significance via) null distribution analytically:
measDist = calc.computeSignificance();
bias(k) = measDist.getMeanOfDistribution();

fprintf('AIS_Discrete(all cols, k=%d) = %.4f bits from %d samples (bias %.4f,bias corrected %.4f)\n', ...
    k, result, calc.getNumObservations(), bias(k), result - bias(k));

end

figure(7);
plot(results, 'rx');
hold on;
plot(bias, 'bo');
biasCorrectedAIS = results - bias;
plot(biasCorrectedAIS, 'g+');
hold off;
xlabel('k');
ylabel('AIS, bits');
% ylim([-4.5 4.5]);
xlim([0 6.5]);
legend('AIS raw', 'bias', 'bias corrected AIS')
title('AIS vs K for Bass')

% [value index] = max(biasCorrectedAIS)
% calc.getNumObservations()

% Result for Soprano
% AIS_Discrete(all cols, k=1) = 0.1215 bits from 2604 samples (bias 0.0325,bias corrected 0.0891)
% AIS_Discrete(all cols, k=2) = 0.2490 bits from 2603 samples (bias 0.4869,bias corrected -0.2380)
% AIS_Discrete(all cols, k=3) = 0.4368 bits from 2602 samples (bias 6.8522,bias corrected -6.4155)
% AIS_Discrete(all cols, k=4) = 0.8291 bits from 2601 samples (bias 96.0006,bias corrected -95.1715)
% AIS_Discrete(all cols, k=5) = 0.8561 bits from 2600 samples (bias 1344.5575,bias corrected -1343.7014)
% AIS_Discrete(all cols, k=6) = 0.9656 bits from 2599 samples (bias 18831.0802,bias corrected -18830.1146)

% Result for Alto
% AIS_Discrete(all cols, k=1) = 0.1788 bits from 2604 samples (bias 0.0325,bias corrected 0.1464)
% AIS_Discrete(all cols, k=2) = 0.3367 bits from 2603 samples (bias 0.4869,bias corrected -0.1502)
% AIS_Discrete(all cols, k=3) = 0.5319 bits from 2602 samples (bias 6.8522,bias corrected -6.3203)
% AIS_Discrete(all cols, k=4) = 0.9491 bits from 2601 samples (bias 96.0006,bias corrected -95.0515)
% AIS_Discrete(all cols, k=5) = 0.9678 bits from 2600 samples (bias 1344.5575,bias corrected -1343.5897)
% AIS_Discrete(all cols, k=6) = 1.1408 bits from 2599 samples (bias 18831.0802,bias corrected -18829.9394)

% Result for Tenor
% AIS_Discrete(all cols, k=1) = 0.1790 bits from 2604 samples (bias 0.0325,bias corrected 0.1465)
% AIS_Discrete(all cols, k=2) = 0.3403 bits from 2603 samples (bias 0.4869,bias corrected -0.1466)
% AIS_Discrete(all cols, k=3) = 0.5226 bits from 2602 samples (bias 6.8522,bias corrected -6.3297)
% AIS_Discrete(all cols, k=4) = 0.9229 bits from 2601 samples (bias 96.0006,bias corrected -95.0777)
% AIS_Discrete(all cols, k=5) = 0.9451 bits from 2600 samples (bias 1344.5575,bias corrected -1343.6124)
% AIS_Discrete(all cols, k=6) = 1.1688 bits from 2599 samples (bias 18831.0802,bias corrected -18829.9114)

% Result for Bass
% AIS_Discrete(all cols, k=1) = 0.1792 bits from 2604 samples (bias 0.0325,bias corrected 0.1467)
% AIS_Discrete(all cols, k=2) = 0.3765 bits from 2603 samples (bias 0.4869,bias corrected -0.1105)
% AIS_Discrete(all cols, k=3) = 0.5537 bits from 2602 samples (bias 6.8522,bias corrected -6.2985)
% AIS_Discrete(all cols, k=4) = 0.9808 bits from 2601 samples (bias 96.0006,bias corrected -95.0198)
% AIS_Discrete(all cols, k=5) = 0.9966 bits from 2600 samples (bias 1344.5575,bias corrected -1343.5609)
% AIS_Discrete(all cols, k=6) = 1.1759 bits from 2599 samples (bias 18831.0802,bias corrected -18829.9043)
