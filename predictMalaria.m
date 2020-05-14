function [predictions,imds] = predictMalaria(sourceFolder, snn, cnn)
    % This function classifies RBCs of the smears in the sourceFolder into
    % malaria parasitized or not.
    % Inputs: 
    % 1. sourceFolder
    % 2. snn: Semantic Neural Network that will segment the RBCs from the
            % smears.
    % 3. cnn: Convolutional Neural Network that classifies each of the RBCs
            % into malaria parasitized or not.
    
    tic
    extractRBC(sourceFolder,snn);
    [~,foldername] = fileparts(sourceFolder);
    imds = imageDatastore([pwd,'/rbcs_',foldername,'_mask']);
    predictions = classify(cnn, imds);
    toc
end