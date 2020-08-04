% MATLAB Script to read and preprocess NetStation EGI segmented Raw Data
% 1. Read Data (-ftd file)
% 2. Import raw data and save as EEGLab dataset. Export Events (seconds).
% 3. Import Adapted Events File, containing adapted triggers and auditory cues
% 4. Filter the data -- 
% 5. Re-reference the data to the linked mastoids or common



for V_Counter = 1:length(CA_Participants)

  V_Participant = CA_Participants{V_Counter};
  V_DataFile = fullfile(V_FileOut, [V_Participant, '.set']);
EEG = pop_loadset('filename', V_DataFile);
% NO DOWNSAMPLING ANYMORE so ICA has more samples!!! Downsample the 500 Hz data to 250 Hz

  %EEG = pop_resample(EEG,250);

% Filter the data -- We've adapted Katrin's version of this part

% Define Filter Parameters

  A_fcutoff = [0.3 40];    % 0.3 to 40Hz Bandpass: Highpass: 0.3 Hz + Lowpass: 40 Hz
  V_tbw = A_fcutoff(1)/2;  % Transition Bandwidth???
  V_dev = 0.001;           % Filter Ripple???

  V_mhp_kaiser = pop_firwsord('kaiser',EEG.srate,V_tbw,V_dev);
  V_beta = pop_kaiserbeta(V_dev);

  [EEG,com,Bhp] = pop_firws(EEG, 'fcutoff', [A_fcutoff], 'ftype','bandpass', 'wtype', 'kaiser', 'warg', V_beta, 'forder', V_mhp_kaiser); % From A Widmann's firfilt 1.6.1 plugin

  
  
  % Remove line noise using CleanLine
  EEG = pop_cleanline(EEG, 'bandwidth', 2,'chanlist', [1:EEG.nbchan], 'computepower', 0, 'linefreqs', [50 100 150 200 250],...
    'normSpectrum', 0, 'p', 0.01, 'pad', 2, 'plotfigures', 0, 'scanforlines', 1, 'sigtype', 'Channels', 'tau', 100,...
    'verb', 1, 'winsize', 4, 'winstep', 4);
  


  % Save the resultant file as an EEGLab .set

  EEG.filename = [V_Participant 'pre_proc.set'];
  EEG.filepath = V_FileOut;
  EEG.comments = char(V_Participant, '; Sampling Rate: 500 Hz; BPF: 0.3-40 Hz;');

% Re-reference the data to the linked mastoids

  EEG = pop_reref(EEG, [], 'keepref', 'on'); % Common/Average reference
%   EEG = pop_reref(EEG, [57 100], 'keepref', 'on');

% Deselect channels in the periphery...they're just way too noisy to make use of!

%   EEG = pop_select(EEG, 'nochannel', [8,1,121,114,95,89,82,74,69,64,44,38,32,25,120,113,107,99,94,88,81,73,68,63,56,49,43,119,48,125,128]);

  % Save the resultant file as an EEGLab .set


  EEG.comments = char([V_Participant, '_bp03_40r_'], '; Sampling Rate: 500 Hz; BPF: 0.3-40 Hz; ReRef: Average;');
  pop_saveset(EEG, 'filename', EEG.filename, 'filepath', EEG.filepath);

  fprintf('########################################################\n\n');
  fprintf('Saved Filter_ReRef data for ... %s.\n\n', V_Participant);


  %Om

end;
