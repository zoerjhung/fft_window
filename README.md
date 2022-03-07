# fft_window
**Author: Ruei-Jyun Hung**

This repository includes the code for the `fft_window.m` Matlab function.




## Usage

### Syntax
`[psd, f] = fft_window(data, t_start, t_end, channels, fs, window, shift);`

### Arguments

```matlab
data                      % Input data
t_start                   % starting time (sec) e.g. 0
t_end                     % ending time (sec) e.g. 26
channels                  % Number of signals e.g. 31
fs                        % Sampling frequency (Hz) e.g. 500
window                    % Length of window (sec) e.g. 4
shift                     % Overlapping e.g. 0.5
```


### Example
