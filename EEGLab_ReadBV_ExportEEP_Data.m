

% 
% V_FolderIn = 'H:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis\EEGRestingState_Vhdr_DataSet\';
% V_DataFolder = 'H:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis\EEGRestingState_EEP_Dataset\';

% EEG = pop_readedf; edf file



%     V_FileOut = fullfile(V_DataFolder, CA_Conditions);


for V_Counter = 1:length(CA_Participants)
    
    V_Participant = CA_Participants{V_Counter};
    V_FileIn = fullfile(V_FolderIn, [CA_Conditions filesep [V_Participant '.vhdr']]);
    fprintf('########################################################\n\n');
    fprintf('Reading %s.\n\n', V_FileIn);
    
    % Read BrainVision .vhdr file
    if strcmp(CA_Conditions,'Assessment2') & strcmp(V_Participant,'Subj_001')
        EEG1 = pop_loadbv('pathfile_EEG');
        EEG2 = pop_loadbv('pathfile_EEG');
        EEG = pop_mergeset(EEG1,EEG2,'keepall');
    else
        EEG = pop_loadbv('pathfile_EEG');
    end
    EEG.filename = [V_Participant '.set'];
        EEG.filepath = V_FileOut;
        EEG.comments = char([V_Participant], '; Raw Sampling Rate: 500 Hz;');
        % Insert channel information
        
        for n = 1 : numel(Labels)
            
            EEG.chanlocs(n).labels = Labels{n};
            
        end
        EEG = pop_chanedit(EEG,  'lookup');
        
%         plot_channels(EEG.data, EEG.times, Labels, 200, 'raw data')
        
        
        
        
        % Export CNT and TRG files using the eepio plugin
        EEG = eeg_checkset( EEG );
      pop_saveset(EEG, 'filename', EEG.filename, 'filepath', EEG.filepath);
      
      
      % Export the Events list for further processing (outside EEGLab)
      V_EventsFile = fullfile(V_FileOut, [V_Participant, '.events']);
      %pop_expevents(EEG, V_EventsFile, 'samples');
      % Exporting Event latencies as samples would mean that, the output always
      % depends upon the sampling frequency.  And in turn, all calculations in
      % InsertAuditoryTriggers etc. need to take into account the sampling
      % frequency. For instance, when the data is down-sampled, this must also
      % be changed inside Insert Auditory Triggers script.  To avoid these
      % interdependencies as well as to keep it more human-readable and similar
      % to .trg files, we export the events in seconds here (Not possible in GUI!).
      pop_expevents(EEG, V_EventsFile, 'seconds');

      fprintf('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n\n');
      fprintf('Exported Brain Vision Data as Dataset file ... %s.\n\n', V_Participant);
      fprintf('########################################################\n\n');
        
end
