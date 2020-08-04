for V_Counter = 1:length(CA_Participants)

  V_Participant = CA_Participants{V_Counter};
  V_DataFile = fullfile(V_Icaout, [V_Participant, 'final.set']);
  EEG = pop_loadset('filename', V_DataFile);
  EEG = pop_resample(EEG, 256);
  
   % Save the resultant file as an EEGLab .set

    EEG.filename = [V_Participant 'downsampled_final.set'];
    EEG.filepath = V_Icaout;
    EEG.comments = char([V_Participant, '_bp03_40r_sphint'], '; Sampling Rate: 256 Hz; BPF: 0.3-40 Hz; ReRef: Average; SASICA based ICA Pruned Original Data with interpolated missing channels');
    pop_saveset(EEG, 'filename', EEG.filename, 'filepath', EEG.filepath);



    fprintf('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n\n');
    fprintf('Saved ICA Pruned Interpolated data as EEP CNT file ... %s.\n\n', V_Participant);
    fprintf('########################################################\n\n');

  
end


