function query = generateQuery(filename, query_length, SNR, window_time, fs_target, n_bits_per_window)

  % This function selects a random, noisy sample from the audio file filename
  %
  % Inputs:
  % filename - name of the file to sample from
  % SNR - amount of noise to add (signal-to-noise ratio in dB)
  % window_time - duration of the spectrogram window (in seconds)
  % fs_target - desired sampling rate (we'll use 4kHz)
  % n_bits_per_window - # of bits used to represent each time-slice of the spectrogram; we'll use 16
  %
  % Outputs:
  % features - query_length×1 vecto of 16-bit decimal numbers, representing the noisy query
 [well,fs]=audioread(filename);
 goody=well(:,1);
 clean=resample(goody,fs_target,fs);
 window_samples=window_time*fs_target;
 noisy=awgn(clean,SNR,'measured');
 noisyFeatures=extractFeatures(noisy,window_samples,n_bits_per_window);
 randomStart=randi(length(noisyFeatures)-32,1);
 query=noisyFeatures(randomStart:randomStart+31);
end
