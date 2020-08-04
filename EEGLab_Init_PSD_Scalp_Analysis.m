% Some Labels

% Emispheres
% Left_Labels = [ 2:11 13:15 32 33 35:38 40:47];  
% Right_Labels = [ 17:22 24:31 49:52 54: 63];
Left_Labels = find(ismember(Labels,{'F3','F7','FT9','FC5','FC1','C3','T7','TP9','CP5','CP1','P3',...
    'P7','O1','AF7','AF3','F1','F5','FT7','FC3','C1','C5','TP7','CP3','P1','P5','PO7','PO3'}));
Right_Labels = find(ismember(Labels,{'F4','F8','FT10','FC6','FC2','C4','T8','TP10','CP6','CP2','P4',...
    'P8','O2','AF8','AF4','F2','F6','FT8','FC4','C2','C6','TP8','CP4','P2','P6','PO8','PO4','Fp2'}));

% Regional

% Left_Frontal_Labels = [33 32 35 36 2 3 ];
% Left_Central_Labels = [5 6 38 37 40 41 7 8 43 10 11];
% Left_V1_Labels = [13 44 45 14 46 47 15];
% Right_Frontal_Labels = [31 62 63 29 30 60 61]; 
% Right_Central_Labels= [27 28 58 59 57 56 24 25 54 21 22];
% Right_Posterior_Labels = [18 19 51 52 49 50 17];


Left_Frontal_Labels = find(ismember(Labels,{'AF3','AF7','F1','F3','F5','F7'}));
Left_Central_Labels = find(ismember(Labels,{'FC1','FC3','FC5','FT7','C1','C3','C5','T7','CP1',...
    'CP3','CP5'}));
Left_Posterior_Labels = find(ismember(Labels,{'P1','P3','P5','P7','PO7','PO3','O1'}));
Right_Frontal_Labels = find(ismember(Labels,{'Fp2','AF4','AF8','F2','F4','F6','F8'}));
Right_Central_Labels= find(ismember(Labels,{'FC2','FC4','FC6','FT8','C2','C4','C6','T8','CP2',...
    'CP4','CP6'}));
Right_Posterior_Labels = find(ismember(Labels,{'P2','P4','P6','P8','PO8','PO4','O2'}));


% Functional

% Left_Motor1_Labels = [ 7 43];
% Left_PreMotor_Labels = [2 36 6 38];
% Left_MotionImagery_Labels = [11 40];
% Left_V1_Labels = [15 46 47];
% Left_V2_Labels = [9 14 45];
% Right_Motor1_Labels = [24 54];
% Right_PreMotor_Labels = [28 29 58 61]; 
% Right_MotionImagery_Labels = [22 57]; 
% Right_V1_Labels = [49 50 17];
% Right_V2_Labels = [20 19 55];


Left_Motor1_Labels = find(ismember(Labels,{'C3','CP3'}));
Left_PreMotor_Labels = find(ismember(Labels,{'F3','F1','FC3','FC1'}));
Left_MotionImagery_Labels = find(ismember(Labels,{'C1','CP1'}));
Left_V1_Labels = find(ismember(Labels,{'PO7','PO3','O1'}));
Left_V2_Labels = find(ismember(Labels,{'TP9','P7','P5'}));
Right_Motor1_Labels = find(ismember(Labels,{'C4','CP4'}));
Right_PreMotor_Labels = find(ismember(Labels,{'F2','F4','FC2','FC4'}));
Right_MotionImagery_Labels = find(ismember(Labels,{'C2','CP2'}));
Right_V1_Labels = find(ismember(Labels,{'PO4','PO8','O2'}));
Right_V2_Labels = find(ismember(Labels,{'TP10','P8','P6'}));


% Couples for BSI Index

BSI_freq = [1 40];
BSI_couples_Labels_temp = {'AF7','AF8';'AF3','AF4'; 'F7','F8'; 'F5','F6';'F3', 'F4';'F1','F2';...
    'FT9','FT10';'FT7','FT8';'FC5', 'FC6';'FC3','FC4';'FC1', 'FC2';'T7','T8';'C5','C6';...
    'C3','C4';'C1','C2';'TP9','TP10';'TP7','TP8';'CP5','CP6';'CP3','CP4';'CP1','CP2';...
    'P7','P8';'P5','P6';'P3','P4';'P1','P2';'PO7','PO8';'PO3','PO4';'O1','O2' } ;
Number_Couples = size(BSI_couples_Labels_temp,1); 
BSI_couples_Labels  = zeros(Number_Couples,2);

for ii = 1: Number_Couples
    BSI_couples_Labels(ii,:) = find(ismember(Labels,BSI_couples_Labels_temp(ii,:)));
end
% Calculate PSD Each Electrode (for dB 10*1og10(x))


noverlap = 1;
t_win = 4; %resolution .25 Hz
sample_freq  = 256; 
n_win = t_win*sample_freq;
nfft = n_win;


%  Define Frequency Bands:

 Delta = [1 4];
 Theta = [ 4 8];
 Alpha = [ 8 12];
 Beta = [ 12 30];
 Gamma = [ 30 100];
 

