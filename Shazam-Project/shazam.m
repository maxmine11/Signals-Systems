% Main Shazam File

window_time = 0.37; % duration (sec) of each window
fs_target = 4000;   % desired sampling rate

n_bits_per_window = 16; % quantization of frequency
audio_directory = 'data';   % directory with test data
audio_database = sprintf('%s/db.mat', audio_directory); % database file


%% Database Prep
% find all the files in the data directory
files = getFiles(audio_directory);   

% load the database from a .mat file if it exists,
%  otherwise generate it from scratch and save it out.
if exist(audio_database, 'file') == 2
  load(audio_database,'songs');
  disp('Database loaded.')
else
  disp('Generating the database .... ')
  % TODO: implement makeDatabase
  songs = makeDatabase(files, window_time, fs_target, n_bits_per_window);
  save(audio_database,'songs');
  disp('Database constructed.');
end


%% Query Generation
disp('Generating query sample ... ')

% Play with these values and see how it affects performance!
SNR = Inf;            % signal-to-noise ratio of queries in dB
query_length = 32;  % length of queries in features
threshold = 0.5;     % maximum error a "match" can have

n_runs = 10;   % how many test queries to generate
incorrect = 0; % how many songs you guessed wrong
correct = 0;   % how many songs you correctly guessed
declined = 0;  % how many songs you didn't have an answer for

bestThresholdSoFar = 1;
bestMatchSong = '';
for p = 1:n_runs;
    rander=randi(length(songs),1);
    queryFilename=songs(rander).name;
    query = generateQuery(queryFilename,query_length, SNR, window_time, fs_target, n_bits_per_window);
    % TODO: Shazam! Implement the algorithm, and measure correctness.
     for i = 1:length(songs)       
        for j = 1:length(songs(i).features)-query_length
            cleanThing = songs(i).features;
            cleanThing = cleanThing(j:j+query_length-1);
            Thold = ber(query,cleanThing,query_length);
            if(Thold<bestThresholdSoFar) && (Thold < threshold)
                bestThresholdSoFar = Thold;
                bestMatchSong = songs(i).name;
            end
        end        
    end
    
   if(strcmp(bestMatchSong,'') == 1)
        declined = declined + 1;
    elseif(strcmp(bestMatchSong,queryFilename) == 1)
        correct = correct + 1;
    else
        incorrect = incorrect + 1;
   end
   bestThresholdSoFar = 1;
   bestMatchSong = '';
end

frac_correct = correct/(correct+incorrect);
fprintf('%g%% correct!\n', 100*frac_correct);
fprintf('  (Declined to answer %d/%d.)\n', declined, n_runs);

