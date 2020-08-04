%%%Om #!/usr/local/bin/matlab%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATLAB Script to interpolate missing channels (and throw some away)
% 1. Load THE_ICA_PRUNED_DATASET from the previous step.
% 2. Interpolate missing channels
% 3. And if you like, throw away some peripheral channels (optional)
% 4. Save the dataset.
% 5. Export it to the good old EEP format using the eepio plugin.
%    https://github.com/widmann/eepio
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%m


for V_Counter = 1:length(CA_Participants)

    V_Participant = CA_Participants{V_Counter};

    V_DataFile = fullfile(V_Icaout,[V_Participant, 'ica_pruned.set']);
    EEG = pop_loadset('filename', V_DataFile);




    % Settings for channel interpolation (using spherical spline method).

    ElectrodeLocations_file = 'Original_Location63Cap.mat';
    load(ElectrodeLocations_file);

    % Spherical Interpolation of all missing channels
    EEG = pop_interp(EEG, ChanLog_Original, 'spherical');



    % Save the resultant file as an EEGLab .set

    EEG.filename = [V_Participant 'final.set'];
    EEG.filepath = V_Icaout;
    EEG.comments = char([V_Participant, '_bp03_40r_sphint'], '; Sampling Rate: 500 Hz; BPF: 0.3-40 Hz; ReRef: Average; SASICA based ICA Pruned Original Data with interpolated missing channels');
    pop_saveset(EEG, 'filename', EEG.filename, 'filepath', EEG.filepath);



    fprintf('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n\n');
    fprintf('Saved ICA Pruned Interpolated data as EEP CNT file ... %s.\n\n', V_Participant);
    fprintf('########################################################\n\n');

%  Om

end;


