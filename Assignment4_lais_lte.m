%% Setup
% Add JIDT jar library to the path, and disable warnings that it's already there:
warning('off','MATLAB:Java:DuplicateClass');
javaaddpath('C:\Users\maria\OneDrive\Documents\infodynamics-dist-1.5\infodynamics.jar');
% Add utilities to the path
addpath('C:\Users\maria\OneDrive\Documents\infodynamics-dist-1.5\demos\octave');

% 0. Load/prepare the data:
data = load('C:\Users\maria\OneDrive\Documents\1USyd\2nd_sem\CSYS5030\assessment\Assignment3-4\bwv244_D_notes.csv');


%% Active Information Storage
variable = octaveToJavaIntArray(data(:,1)); % 1 = Soprano, 2 = Alto, 3 = Tenor, 4 = Bass

k = 4;
% 1. Construct the calculator:
calc1 = javaObject('infodynamics.measures.discrete.ActiveInformationCalculatorDiscrete', 14, k);
% 2. No other properties to set for discrete calculators.
% 3. Initialise the calculator for (re-)use:
calc1.initialise();
% 4. Supply the sample data:
calc1.addObservations(variable);
% 5. Compute the estimate:
result1 = calc1.computeAverageLocalOfObservations();
% 6. Compute the (statistical significance via) null distribution empirically (e.g. with 100 permutations):
measDist1 = calc1.computeSignificance(100);

fprintf('AIS_Discrete(col_0) = %.4f bits (null: %.4f +/- %.4f std dev.; p(surrogate > measured)=%.5f from %d surrogates)\n', ...
	result1, measDist1.getMeanOfDistribution(), measDist1.getStdOfDistribution(), measDist1.pValue, 100);

% Pull out the local AIS values for each point in the time series:
localAISValues = calc1.computeLocalFromPreviousObservations(variable);

%% Transfer Entropy
% Column indices start from 1 in Matlab:
% 1 = Soprano, 2 = Alto, 3 = Tenor, 4 = Bass
source = octaveToJavaIntArray(data(:,4));
destination = octaveToJavaIntArray(data(:,1));

% 1. Construct the calculator:
calc2 = javaObject('infodynamics.measures.discrete.TransferEntropyCalculatorDiscrete', 14, k, 1, 1, 1, 1);
% 2. No other properties to set for discrete calculators.
% 3. Initialise the calculator for (re-)use:
calc2.initialise();
% 4. Supply the sample data:
calc2.addObservations(source, destination);
% 5. Compute the estimate:
result2 = calc2.computeAverageLocalOfObservations();
% 6. Compute the (statistical significance via) null distribution empirically (e.g. with 100 permutations):
measDist2 = calc2.computeSignificance(100);

fprintf('TE_Discrete(col_0 -> col_1) = %.4f bits (null: %.4f +/- %.4f std dev.; p(surrogate > measured)=%.5f from %d surrogates)\n', ...
	result2, measDist2.getMeanOfDistribution(), measDist2.getStdOfDistribution(), measDist2.pValue, 100);

% Pull out the local TE values for each point in the time series:
localTE = calc2.computeLocalFromPreviousObservations(source, destination);
localTE = javaMatrixToOctave(localTE);

%% Plot
% Combined plot
figure(10);

tiledlayout(3,1);
nexttile
% plot(data(:,2), '-go');
% plot(data(:,3), '-b+');
plot(data(:,4), '-y*');
hold on;
plot(data(:,1), '-rx');
hold off;
title('Distribution of Bass and Soprano notes(bwv244.29-a)');
xlabel('Note sequence');
ylabel('Notes');
legend('Source(Bass)', 'Target(Soprano)');
xlim([1014 1222]);
ylim([0 13]);
grid;

nexttile
plot(k+1:length(localAISValues), localAISValues(k+1:end), '-*');
title('AIS of Soprano, k = 4')
ylabel('Local AIS, bits');
xlabel('Note sequence');
xlim([1014 1222]);
grid;

nexttile
plot(k+1:length(localTE), localTE(k+1:end), '-x');
% BreakPlot(k+1:length(localTE),localTE(k+1:end),0.35,0.9,'Line');
title('Transfer entropy from Bass to Soprano, k =4')
ylabel('Local TE, bits');
xlabel('Note sequence');
xlim([1014 1222]);
grid;

% Individual plots

figure(11);
% plot(data(:,2), '-go');
% plot(data(:,3), '-b+');
plot(data(:,4), '-y*');
hold on;
plot(data(:,1), '-rx');
hold off;
title('Distribution of Bass and Soprano notes(bwv244.29-a)');
xlabel('Note sequence');
ylabel('Notes');
legend('Source(Tenor)', 'Target(Soprano)');
xlim([1014 1222]);
ylim([0 13]);
grid;

figure(12);
plot(k+1:length(localAISValues), localAISValues(k+1:end), '-*');
title('AIS of Soprano, k = 4')
ylabel('Local AIS, bits');
xlabel('Note sequence');
xlim([1014 1222]);
grid;
% Result: AIS_Discrete(col_0) = 0.8291 bits (null: 0.2184 +/- 0.0088 std dev.; p(surrogate > measured)=0.00000 from 100 surrogates)

figure(13);
plot(k+1:length(localTE), localTE(k+1:end), '-x');
% BreakPlot(k+1:length(localTE),localTE(k+1:end),0.4,0.8,'Line');
title('Transfer entropy from Bass to Soprano, k =4')
ylabel('Local TE, bits');
xlabel('Note sequence');
xlim([1014 1222]);
grid;
% Result: TE_Discrete(col_0 -> col_1) = 0.0075 bits (null: 0.1280 +/- 0.0069 std dev.; p(surrogate > measured)=1.00000 from 100 surrogates)


