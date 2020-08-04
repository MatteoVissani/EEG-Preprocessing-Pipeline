for V_Counter = 1:length(CA_Participants)

    V_Participant = CA_Participants{V_Counter};
    
    V_DataFile = fullfile(V_Icaout,[V_Participant, 'final.set']);
    EEG = pop_loadset('filename', V_DataFile);
    title = [V_Participant,'_',CA_Conditions, ' : Pruned data'];
    plot_channels(EEG.data, EEG.times*10^-3/60, Labels, 200, title)
end
