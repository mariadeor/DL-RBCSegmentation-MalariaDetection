% Copyright (c) 2020 Maria Delgado-Ortet (github.com/mariadeor)
function extract_rbc(folder,snn)
           
    % This function saves the masked and cropped RBCs in a folder 
    % inside the working directory under the name of 
    %'rbcs_foldername_mask', where foldername is the name of the 
    % input folder.
    % Inputs: 
    % 1. folder: folder that contains the wide field blood smears.
    % 2. snn: trained SNN to segment RBCs.
   
    [~,foldername] = fileparts(folder);
    filenames = dir([folder '/*.jpg']);
    %STEP 1) Create imageDatastore of the folder.
        fullimds = imageDatastore(folder);
        inputSize = [600 800];
        fullimds.ReadFcn = @(loc)imresize(imread(loc),inputSize);

    %STEP 2) Semantic segmentation of the smears.
        pxdsSegmentation = semanticseg(fullimds, snn, ...
            'MiniBatchSize',4,...
            'WriteLocation',tempdir,...
            'Verbose',false);

    %STEP 3) Each of the smear labels is
        %extracted, processed and analyzed in order to extract the 
        %centroids of the erythroctytes for its later cropping.

    mkdir(['rbcs_', foldername, '_mask']) % A new folder is created to 
                                          % save the cropped and masked 
                                          % RBCs.

    nbr_images = length(pxdsSegmentation.Files);
    for i=1:nbr_images

        Ilab = imread(pxdsSegmentation.Files{i});
        Ilab = (Ilab == 1);

        Ilab_nb = imclearborder(Ilab);
        Ilab_nb  =  bwareaopen(Ilab_nb,700) ;
        stats = regionprops('table',Ilab_nb, 'area','centroid','eccentricity');

        rows = ~(stats.Area>35000 | stats.Eccentricity>0.65);
        vars = {'Area', 'Centroid', 'Eccentricity'};
        selected = stats(rows,vars);

        radius = 90;

     %STEP 4) Cropping of the erythrocytes and the labels.
        image_name = filenames(i).name;
        I = imread(fullfile(folder,image_name));
        I = imresize(I, inputSize);
        idx = 1;
        for rbc_idx=1:height(selected)
            [patch, flag] = get_patch(I,floor(selected.Centroid(rbc_idx,1)),floor(selected.Centroid(rbc_idx,2)),radius); % The RBCs are cropped.
            [label, ~] = get_patch(Ilab,floor(selected.Centroid(rbc_idx,1)),floor(selected.Centroid(rbc_idx,2)),radius); % The label patches are cropped.
                if flag == 1
                    label = centralRBCmask(label);
                    patch = uint8(patch.*label); %Keep only the pixels of the central RBC.
                    imfilename = ([image_name(1:(length(image_name)-4)),'_',num2str(idx),'.jpg']);
                    idx = idx+1;
                    imwrite(patch,[pwd,['/rbcs_',foldername,'_mask/'],imfilename]);
                end
        end
    end
end
