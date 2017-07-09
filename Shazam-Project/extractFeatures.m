function features = extractFeatures(audio, window_samples, n_bits_per_window)

  % This function extracts features from the audio file 'filename'
  %
  % Inputs:
  % audio - column vector representing the audio waveform
  % window_samples - duration of the spectrogram window (in samples)
  % n_bits_per_window - # of bits used to represent each time-slice of the spectrogram; we'll use 16
  %
  % Outputs
  % features - Nx1 vector of 16-bit decimal numbers, representing the
  %           features of this audio file, where N is related to the 
  %           length of the audio.

  [S F T P]=spectrogram(audio,window_samples,window_samples/2,window_samples);
  power=abs(S).^2;
  interval=ceil(size(S,1)/17);
  S_N=zeros(17,length(S(1,:)));
  s=0;
 for bit =1:17; 
     for row = (1 + s):bit*interval;
         if row > length(S(:,1))
             S_N=S_N;
         else
             S_N(bit,:)= S_N(bit,:) + power(row,:);
         end
     end
     s = s + interval;
 end
 S_r=[];
 for col = 1:length(S(1,:));
     for r = 1:16;
         if S_N(r,col) > S_N(r+1,col)
             S_r(r,col)=1;
         else
             S_r(r,col)=0;
         end
     end
 end
 S_r=bi2de(S_r')';
 features=S_r;
          
  %interval=ceil((window_samples/2)/17);
  
end