% Copyright (c) 2020 Maria Delgado-Ortet (github.com/mariadeor)
function mask = centralRBCmask(binary_label)

    % This function returns the mask of the centered RBC only at the input 
    % binary mask.
    % Inputs: 
    % 1. binary_label: Pixels equal to 1 belong to RBCs.

    binary_label = imclearborder(binary_label); % Removal of the peripheral RBCs.
    binary_label = imfill(binary_label); % Filling of the holes of the RBC.
    SE = strel('disk',50);
    mask = imclose(binary_label,SE); % Closing of the mask.
    
end
