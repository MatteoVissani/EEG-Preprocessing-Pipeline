

V_Participant = 'xx';


switch Ass
    case 1
        CA_Participants = {'Subj_003','Subj_004','Subj_006','Subj_008','Subj_009','Subj_0010'};  % List of Participants
        CA_Conditions = 'Assessment1';
    case 2
      %  CA_Participants = {'Subj_001','Subj_003','Subj_004','Subj_006','Subj_009','Subj_0010'};  % List of Participants
        CA_Participants = {'Subj_009'};
        CA_Conditions = 'Assessment2';
    case 3
         CA_Participants = {'Subj_003','Subj_004','Subj_006','Subj_008','Subj_009'};  % List of Participants
%CA_Participants = {'Subj_006'};
        CA_Conditions = 'Assessment3';
    case 4
       % CA_Participants = {'Subj_001','Subj_003','Subj_004','Subj_008','Subj_009','Subj_0010'};  % List of Participants
        CA_Conditions = 'Assessment4';
        CA_Participants = {'Subj_009'};
        

end

if flag_PC

    V_FolderIn = 'H:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis\EEGRestingState_Vhdr_DataSet\';
    V_DataFolder = 'H:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis\EEGRestingState_EEP_Dataset\';
    V_Ica = 'H:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis\EEGRestingState_ICAOutput';
    V_PSD_Output = 'H:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis\EEGRestingState_PSD_Output';
    V_Loreta = 'H:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis\EEG_RestingState_ROI_eLoreta';
    V_eConnect = 'H:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis\EEG_RestingState_ROI_eConnectome';
    path_to_be_searched_EEGLAB = 'C:\Users\Utente\Desktop\Matlab Scripts\eeglab14_1_1b';
    locpath = ['H:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis' filesep 'electrod_labels.txt'];
    path_to_be_searched_FIELDTRIP = 'C:\Users\Utente\Desktop\Matlab Scripts\fieldtrip-20180423';
else
    V_FolderIn = 'F:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis\EEGRestingState_Vhdr_DataSet\';
    V_DataFolder = 'F:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis\EEGRestingState_EEP_Dataset\';
    V_Ica = 'F:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis\EEGRestingState_ICAOutput';
    V_PSD_Output = 'F:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis\EEGRestingState_PSD_Output';
    V_Loreta = 'F:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis\EEG_RestingState_ROI_eLoreta';
    V_eConnect = 'F:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis\EEG_RestingState_ROI_eConnectome';
    path_to_be_searched_EEGLAB = 'C:\Users\asus\Desktop\Matlab scripts\eeglab14_1_1b';
    locpath = ['F:\Vissani_Mazzoni_PhD_Folder\EEG Studies\Analysis' filesep 'electrod_labels.txt'];
    path_to_be_searched_FIELDTRIP = 'C:\Users\asus\Desktop\Matlab scripts\fieldtrip-20180423';

end

V_FileOut = fullfile(V_DataFolder, CA_Conditions);

V_Participants_Ignored = 0;


V_Icaout = [V_Ica filesep CA_Conditions];



V_LoretaOutput = [ V_Loreta filesep CA_Conditions];



V_eConnectOutput = [ V_Loreta filesep CA_Conditions];

% check if  eeglab is in  matlab path, otherwise add it
path_list_cell = regexp(path,pathsep,'Split');
% % Desktop PC
%path_to_be_searched = 'C:\Users\asus\Desktop\eeglab14_1_1b' % personal pc
if any(ismember(path_to_be_searched_EEGLAB,path_list_cell))
    disp('Yes, this directory is in MATLAB path');
else
    disp('No, this directory is not in MATLAB path');
    disp('Adding eeglab in path...')
    addpath(path_to_be_searched_EEGLAB)
end




[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;



% check if  FieldTrip is in  matlab path, otherwise add it
%path_to_be_searched = 'C:\Users\Utente\Desktop\Matlab Scripts\eeglab14_1_1b'; % Desktop PC
%path_to_be_searched = 'C:\Users\asus\Desktop\eeglab14_1_1b' % personal pc
if any(ismember(path_to_be_searched_FIELDTRIP,path_list_cell))
    disp('Yes, this directory is in MATLAB path');
else
    disp('No, this directory is not in MATLAB path');
    disp('Adding fieldtrip in path...')
    addpath(path_to_be_searched_FIELDTRIP)
end


% load channel locations
fid = fopen(locpath);
Labels = textscan(fid,'%s');
fclose(fid);
Labels = Labels{:};