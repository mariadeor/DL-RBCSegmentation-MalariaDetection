% Copyright (c) 2020 Maria Delgado-Ortet (github.com/mariadeor)
function [predictions,imds] = predictMalaria(folder, snn, cnn)
    
    % This function classifies masked and cropped RBCs from the wide field blood smears
    % into malaria parasitized or not.
    % Inputs: 
    % 1. folder: folder that contains the wide field blood smears.
    % 2. snn: Semantic Neural Network that will segment the RBCs from the
            % smears.
    % 3. cnn: Convolutional Neural Network that classifies each of the RBCs
            % into malaria parasitized or not.
    
    tic
    extractRBC(folder,snn);
    [~,foldername] = fileparts(folder);
    imds = imageDatastore([pwd,'/rbcs_',foldername,'_mask']);
    predictions = classify(cnn, imds);
    toc

end
