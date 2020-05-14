% Copyright (c) 2020 Maria Delgado-Ortet (github.com/mariadeor)
% This is a CDSS for the diagnosis of malaria. It combines the usage of 
% Deep Learning tools (Segmentation Neural Networks (SNN) and 
% Convolutional Neural Networks (CNN) for classification) and image analysis 
% to help the pathologist reach the final decision.
 
% For any enqueries or suggestions please contact the main developer 
% through mariadeor@hotmail.com

%%%%%%%%%%%

% HELLO USER! TO TAKE ADVANTAGE OF THIS MALARIA CDSS, YOU HAVE TO:
    % 1) Make sure the following files are in the folder:
        %- centralRBCmask.m
        %- cnn.mat
        %- extractRBC.m
        %- get_patch.m
        %- snn.mat
        %- predictMalaria.m
    % 2) Click the button "RUN" located in the menu above.
    % 3) A browser of your computer will pop up. Select the folder that 
            % contains the wide field blood smears that you would like to 
            % analyze.
    % 4) Wait for the results to be displayed:
        % - All the cropped and masked RBCs from your slides will be saved 
            % in a folder in this same folder.
        % - The percentage of RBCs predicted as potentially infected will 
            % be displayed in the window below.
        % - The potentially infected RBCs will appear in the screen. Hope 
            % they help you making the final decision!

%%%%%%%%%%

sourceFolder = uigetdir; %It opens the browser and allows to pick the 
                         %folder that contain the images to analyze.


cnn = load('cnn.mat');
cnn = cnn.net;
ssn = load('ssn.mat');
ssn = ssn.net;

[predictions, imds] = predictMalaria(sourceFolder, ssn, cnn);


% Percentages calculation:
nbr_infected = sum(predictions == categorical(1));

fprintf('A total of %.0f', nbr_infected, ' RBCs have been predicted to be infected. This represents the %0.2f', (nbr_infected/length(predictions))*100, '\% of the total number of cells analyzed.');

% Display of the potentially infected cells:
for i = 1:nbr_infected
    figure(i)
    imshow(imread(imds.Files{i,1}))
end
