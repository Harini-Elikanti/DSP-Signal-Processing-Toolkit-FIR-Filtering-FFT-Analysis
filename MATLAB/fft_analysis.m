clc;
clear;
close all;

%% Parameters

Fs = 1000;
N = 1000;

f1 = 50;
f2 = 200;

t = (0:N-1)/Fs;

%% Generate signal

signal = sin(2*pi*f1*t) + ...
         0.5*sin(2*pi*f2*t);

%% Add noise

rng(1);

noise = 0.3 * randn(1,N);

noisy_signal = signal + noise;

%% FIR filter

filter_order = 20;
cutoff_frequency = 100;

normalized_cutoff = cutoff_frequency/(Fs/2);

h = fir1(filter_order, normalized_cutoff);

filtered_signal = filter(h,1,noisy_signal);

%% FFT of original signal

X = fft(signal);

%% FFT of noisy signal

X_noisy = fft(noisy_signal);

%% FFT of filtered signal

X_filtered = fft(filtered_signal);

%% Frequency axis

f = (0:N-1)*(Fs/N);

%% Magnitude

X_mag = abs(X)/N;
X_noisy_mag = abs(X_noisy)/N;
X_filtered_mag = abs(X_filtered)/N;

%% Plot

figure;

plot(f(1:N/2), X_mag(1:N/2), 'LineWidth', 1);

hold on;

plot(f(1:N/2), X_noisy_mag(1:N/2), 'LineWidth', 1);

plot(f(1:N/2), X_filtered_mag(1:N/2), 'LineWidth', 1);

xlabel('Frequency (Hz)');
ylabel('Magnitude');

title('FFT Analysis');

legend('Original', 'Noisy', 'Filtered');

grid on;
