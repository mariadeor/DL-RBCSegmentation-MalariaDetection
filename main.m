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
snn = load('snn.mat');
snn = snn.net;

[predictions, imds] = predict_malaria(sourceFolder, snn, cnn);

% Percentages calculation:
nbr_infected = sum(predictions == categorical(1));
pct_infected = nbr_infected/length(predictions)*100;

fprintf('A total of %d RBCs have been predicted to be infected.\nThis represents the %4.2f%% of the total number of cells analyzed.\n',nbr_infected,pct_infected);

% Display of the potentially infected cells:
for i = 1:nbr_infected
    figure(i)
    imshow(imread(imds.Files{i,1}))
end
