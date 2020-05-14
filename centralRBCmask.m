function mask = centralRBCmask(label)
% RBCmask function returns a binary image all 0s except the central RBC.
%   Inputs: Label patch. In it, all pixels belonging to RBCs in the image
%   are 1 but there is only interest in keeping the central one.
    
    label = imclearborder(label);
    label = imfill(label);
    SE = strel('disk',50);
    mask = imclose(label,SE);
    
end