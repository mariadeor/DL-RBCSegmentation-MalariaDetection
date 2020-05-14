% Copyright (c) 2020 Maria Delgado-Ortet (github.com/mariadeor)

% This is a Digital Pathology System (DPS) for malaria detection with the 
% use of neural networks. It accepts as input the digital images of peripheral 
% blood (PB) smears in the selected folder and outputs the potentially 
% infected Red Blood Cells (RBCs).

% To use it, run this file and select the folder where the digital images of 
% wide field smears are.

sourceFolder = uigetdir; %It opens the browser and allows to pick the 
                         %folder that contain the images to analyze.


cnn = load('cnn.mat');
cnn = cnn.net;
ssn = load('ssn.mat');
ssn = ssn.net;

[predictions, imds] = predict_malaria(sourceFolder, ssn, cnn);

% Percentages calculation:
nbr_infected = sum(predictions == categorical(1));

fprintf('A total of %.0f', nbr_infected, ' RBCs have been predicted to be infected. This represents the %0.2f', (nbr_infected/length(predictions))*100, '\% of the total number of cells analyzed.');

% Display of the potentially infected cells:
for i = 1:nbr_infected
    figure(i)
    imshow(imread(imds.Files{i,1}))
end
