# EEG-Preprocessing-Pipeline
EEG Preprocessing Pipeline for resting state or ER data


1. There is a script called Main that calls everything (other scripts, EEGLAB, FIELDTRIP ( you can remove it if you are only interested to pre-processing) and other functions). 
2. The script EEGLAB_StartEverything sets up the filepaths for everything. You have to change them according your working directory and your filepaths.
3. The script EEGLab_ReadBV_ExportEEP_Data loads the EEG vmrk files and it converts them in set format that is suitable for eeglab. If you work with other extensions, you have to change something.
4. The script EEGLab_PreProcess_Reref performs filtering and re-referencing. It also applies CleanLine ToolBox that is an EEGLAB's Extension.
5. The script EEGLab_PreIca_v2 allows the remotion of bad segments/channels. You can choose to use among a manual, automatic or a hybrid approach.
6. The script EEGLAB_SASICA_v2 allow the ICA computation and the remotion of bad ICs. You can perform a full automatic or semi-automatic rejection according to your confidence.
7. The script EEGLab_WriteCntData_Interpolate_PostICA allows a spherical interpolation of bad channels (after ICA).
8. The script  EEGLab_PlotPostIca allows the visualization of the effects of your full pipeline.
9. The script EEGLab_DownSample_to_256 allows a downsampling from 500 Hz to 256 Hz.
10. The electrode_label.txt file contains the information about the experimental cap used in the experiment (layout, channels, location, etc.)


Requirements:
- EEGLAB
- Fieldtrip
- SASICA
