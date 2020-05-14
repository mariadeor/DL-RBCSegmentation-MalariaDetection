% Copyright (c) 2020 Maria Delgado-Ortet (github.com/mariadeor)
function [predictions,imds] = predict_malaria(folder, snn, cnn)
    
    % This function classifies masked and cropped RBCs from the wide field blood smears
    % into malaria parasitized or not.
    % Inputs: 
    % 1. folder: folder that contains the wide field blood smears.
    % 2. snn: trained SNN to segment RBCs.
    % 3. cnn: trained CNN that classifies each of the RBCs into malaria parasitized or not.
    
    tic
    extract_rbc(folder,snn);
    [~,foldername] = fileparts(folder);
    imds = imageDatastore([pwd,'/rbcs_',foldername,'_mask']);
    predictions = classify(cnn, imds);
    toc

end
