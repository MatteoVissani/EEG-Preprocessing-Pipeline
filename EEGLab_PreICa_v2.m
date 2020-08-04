% MATLAB Script to perform pre-ICA clean-up of the continuous data
% 1. Load the preprocessed re-referenced dataset
% 2. Automatic Bad Channel Rejection, and save the dataset, say as xyz_..._ica_bc.out
%    %==> This will be the dataset we will use after ICA to remove bad components from!
%    %    Let us call this dataset THE_MAIN_PREICA_DATASET for later reference.
% 3. MANUAL PRE-ICA REJECTION:
%    Load the dataset with bad-channels already removed (one by one!)
%    Mark very bad, out-of-the ordinary artefacts to reject
%    Leave good blink artefacts in place for the ICA to take care of them
%    At the end, click reject: this saves the rejections in the dataset
%                    as well as does some book-keeping, just to be sure.
%
% With inputs from Alessandro Tavano
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%m


for V_Counter = 1 :length(CA_Participants)
    
    V_Participant = CA_Participants{V_Counter};
    V_DataFile = fullfile(V_FileOut, [V_Participant, 'pre_proc.set']);
    EEG = pop_loadset('filename', V_DataFile);
    
    % subj 003 in Assessment 4 give problems
    if or(strcmp(CA_Conditions,'Assessment4') & strcmp(V_Participant, 'Subj_003'), strcmp(CA_Conditions,'Assessment2') & strcmp(V_Participant, 'Subj_004'))
        EEG = EEG;
        V_Channels_Excluded = [];
    else 
    [EEG, V_Channels_Excluded] = pop_rejchan(EEG, 'elec',[1:EEG.nbchan],'threshold',2,'norm','on','measure','spec','freqrange',[0.3 40] );
    end
    % Save information about Bad Channels excluded from ICA
    V_BadChannelsFile = fullfile(V_FileOut,  [V_Participant, '_Bad_Channel_Indices.txt']);
    dlmwrite(V_BadChannelsFile, V_Channels_Excluded, 'delimiter', ',');
    

    % Save the resultant file as an EEGLab .set
    
    EEG.filename = [V_Participant 'ica_bc.set'];
    EEG.filepath = V_FileOut;
    EEG.comments = char([V_Participant, 'ica_bc'], '; Sampling Rate: 500 Hz; BPF: 0.3-40 Hz; ReRef: Linked Mastoids;');
    pop_saveset(EEG, 'filename', EEG.filename, 'filepath', EEG.filepath);
end

 for V_Counter = 1:length(CA_Participants)
% Load the dataset with bad-channels already removed in the previous step
    V_Participant = CA_Participants{V_Counter};
    V_DataFile = fullfile(V_FileOut,  [V_Participant, 'ica_bc.set']);

    EEG = pop_loadset('filename', V_DataFile);


    % Manual Rejection of Bad Sample Segments in Continuous Data
    %  Manually mark bad segments of continuous data in an interactive eegplot
    %  Returns the marked sample intervals in the variable 'V_Rejected_Sample_Range'

    V_Command = 'V_Rejected_Sample_Range = TMPREJ(:,1:2);';   % REJECT button action
    winlength = 5;                 % time range to display in seconds
    scale = 70;                     % amplitude range for channels (uV)

    eegplot(EEG.data,'command',V_Command,'title',[V_Participant ' - Reject time intervals manually'],'events',EEG.event,'spacing',scale,'eloc_file',EEG.chanlocs);

    waitfor(gcf);

    % Automatic rejection
    %[EEG, V_Rejected_Sample_Range] = pop_rejcont(EEG, 'elecrange',[1:EEG.nbchan] ,'freqlimit',[0.3 40] ,'threshold',10,'epochlength',0.5,'contiguous',4,'addlength',0.25,'taper','hamming');

    fprintf('%d interval(s) marked for pre-ICA rejection\n', size(V_Rejected_Sample_Range,1));
    V_RejectionsFile = fullfile(V_FileOut,  [V_Participant, '.rej_pre_ICA']);
    dlmwrite(V_RejectionsFile,(V_Rejected_Sample_Range-1)/EEG.srate,'delimiter','-','precision','%.3f');
    fprintf('Saved file %s.\n',V_RejectionsFile);
%Actually Reject the bad sample segments that were marked just now in the data
    % The following not necessary for the automatic rejection procedure, for
    % things are already rejected as part of pop_rejcont.
    % But absolutely necessary for manual rejection, for things were only
    % marked for rejection, and so not yet out.
    EEG = pop_select(EEG,'nopoint',V_Rejected_Sample_Range);
    clear V_Rejected_Sample_Range;
    
    
    EEG.filename = [V_Participant 'ica_in.set'];
    EEG.filepath = V_FileOut;
    EEG.comments = char([V_Participant, ': Pre-ICA']);
    pop_saveset(EEG, 'filename', EEG.filename, 'filepath', EEG.filepath);
    
%     plot_channels(EEG.data, EEG.times, Labels, 200, ['Subj', V_Participant ,'Assessment1: Clean Data Pre-ICA'])
    
    
end


