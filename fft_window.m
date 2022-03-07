function [psd, f] = fft_window(data, t_start, t_end, channels, fs, window, shift);

% Arguments:
% data                      % Input data
% t_start                   % starting time (sec) e.g. 0
% t_end                     % ending time (sec) e.g. 26
% channels                  % Number of signals e.g. 31
% fs                        % Sampling frequency (Hz) e.g. 500
% window                    % Length of window (sec) e.g. 4
% shift                     % Overlapping e.g. 0.5
%
%
%  Ruei-Jyun Hung completed modification on March 01, 2022
 
 %%
 % valid data points
 sample_start = 1+(fs*t_start);
 sample_end = 1+(fs*t_end);
 temp_data = data(:, sample_start:sample_end);
 sample = sample_end-sample_start; % total samples
 
 % window
 window_sample = fs*window; % length of one window
 shift_sample = window_sample*shift; % length of one shift
 n_window = fix(sample/shift_sample); % numbers of windows
 
 % correcting the real numbers of windows
ind = 1+(n_window-1)*shift_sample+window_sample;
data_length = sample+1; 
if ind > data_length
    n_window_real = n_window-1;
else
    n_window_real = n_window;
end

% frequency
N = window_sample+1; % samples of one window
f = fs*(0:(N/2))/N; % frwquency bins
n_f = size(f,2); % numbers of frwquency bins
psd_window = zeros(channels, n_f);

%%
for i_window = 1:n_window_real
    % data points for each window
    window_start = 1+(i_window-1)*shift_sample;
    window_end = window_start+window_sample;
    temp_window = temp_data(:, window_start:window_end);
    
    % fft
    Y = fft(temp_window, [], 2); % for each row                         
    P2_target = abs(Y/N); 
    P1_target = P2_target(:, 1:N/2+1); 
    P1_target(:, 2:end-1) = 2*P1_target(:, 2:end-1);
    psd_temp_window = P1_target;
    psd_window = psd_window+psd_temp_window;
    clear temp_window Y P2_target P1_target psd_temp_window   
end

psd_avg_window = psd_window/i_window; % culculating the mean of all windows
psd = psd_avg_window;
clear psd_avg_window




end
