clc;
clear;
close all;

%% Signal parameters
Fs = 1000;
N = 1000;

f1 = 50;
f2 = 200;

t = (0:N-1)/Fs;

%% Generate clean signal
signal = sin(2*pi*f1*t) + 0.5*sin(2*pi*f2*t);

%% Add noise
rng(1);                         % Makes noise repeatable
noise = 0.3 * randn(1, N);
noisy_signal = signal + noise;

%% Design FIR low-pass filter
filter_order = 20;
cutoff_frequency = 100;

normalized_cutoff = cutoff_frequency/(Fs/2);

h = fir1(filter_order, normalized_cutoff);

%% Apply FIR filter
filtered_signal = filter(h, 1, noisy_signal);

%% Plot signals
figure;

subplot(3,1,1);
plot(t, signal);
title('Original Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;
xlim([0 1]);

subplot(3,1,2);
plot(t, noisy_signal);
title('Noisy Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;
xlim([0 1]);

subplot(3,1,3);
plot(t, filtered_signal);
title('FIR Filtered Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;
xlim([0 1]);
%% Display FIR coefficients

disp('FIR coefficients:');
disp(h);

% Save coefficients to a text file
fileID = fopen('../Results/fir_coefficients.txt', 'w');

for k = 1:length(h)
    fprintf(fileID, '%.12f\n', h(k));
end

fclose(fileID);

disp('Coefficients saved to Results/fir_coefficients.txt');
