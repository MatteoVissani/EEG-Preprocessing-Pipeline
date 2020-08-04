%%  Main Script: Only for resting State EEGData
% Note: Aggressive Cleaning!!!!
clc%
clear all
close all

Ass = 1;
All_Subjects = {'Subj_001','Subj_003','Subj_004','Subj_006','Subj_008','Subj_009','Subj_0010'};
All_Conditions = {'Assessment1','Assessment2','Assessment3','Assessment4'};
flag_PC = 0; % 0 for personal pc and 1 for desktop

EEGLab_StartEverything



% ##############################################################

%%

% Preprocessing 
%% ##############################
% Phase 1 
EEGLab_ReadBV_ExportEEP_Data
% ###############################

%% ##############################
% Phase 2
EEGLab_PreProcess_Reref
% ###############################

%% ##############################
% Phase 3
EEGLab_PreICa
% ###############################

%% ##############################
% Phase 4
EEGLab_SASICA_v2
% ###############################

%% ##############################
% Phase 5
EEGLab_WriteCntData_Interpolate_PostICA
% ###############################

%% ##############################
% Phase 6
EEGLab_PlotPostIca
% ###############################


%% ##############################
% Phase 7
EEGLab_DownSample_to_256
% ###############################


% #######################################################################


% Power Spectrum Scalp-Analysis


 %% ##############################
% Phase 8
 EEGLab_Init_PSD_Scalp_Analysis
% ###############################


%% ##############################
% Phase 9
EEGLab_PSD_Scalp_Analysis
% ###############################


%%




