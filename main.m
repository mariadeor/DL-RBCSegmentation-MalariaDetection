% Copyright (c) 2020 Maria Delgado-Ortet (github.com/mariadeor)
function [patch,boolean_flag] = get_patch(image, x, y, patch_radius)

    % This function returns a square patch from a larger image centered at a
    % pixel position (x,y).
    % The function works for both grey-scale and colour images (RGB channels)
    % Inputs: 
    % 1. Image
    % 2. x,y: coordinates for center pixel location in image
    % 3. patch_radius: desired radius from center of image

    boolean_flag=true;
    dim = size(image); % Get image dimension values
    dim_tmp = size(dim); % Get number of dimensions
    no_of_dim = dim_tmp(2);
    
    % X and y must be switched to match the image dimension convention
    dim_img_x = dim(2); % Get x dimension length
    dim_img_y = dim(1); % Get y dimension length
    
    % Get number of channels
    if no_of_dim == 2
        channels = 1; % If only 2 dimensions (x,y), then there is only one channel
    elseif no_of_dim == 3 
        channels = dim(3); % If there are 3 dimensions (x,y,z), get the length of the 3rd dimension
    end
    
    % Calculate the patch x and y dimensions (patch size) based on the desired radius
    % 1 pixel is the center point length, add radius values around center point
    patch_x_dim = 2*patch_radius + 1; % Right and left for x
    patch_y_dim = patch_x_dim; % Above and below for y (same length for x and y for square area)
    
    % Calculate patch edge locations
    patch_x_left_edge = x-patch_radius; % Left edge
    patch_x_right_edge = x+patch_radius; % Right edge
    patch_y_upper_edge = y-patch_radius; % Upper edge
    patch_y_lower_edge = y+patch_radius; % Lower edge
    
    % Check if center point is outside image bounds
    if (x > dim_img_x) || (y > dim_img_y) || (x <= 0) || (y <= 0) 
        msg = strcat('Center point (x,y):(',num2str(x),',',num2str(y),') is outside image bounds x: 1-',num2str(dim_img_x), ', y:1-', num2str(dim_img_y));
       % error(msg);
        boolean_flag = false;
    % Check if patch edge points are outside image bounds
    elseif (patch_x_right_edge > dim_img_x) || (patch_y_lower_edge > dim_img_y) || (patch_x_left_edge <= 0) || (patch_y_upper_edge <= 0)
        msg = strcat('The patch edges x from:',num2str(patch_x_left_edge),' to:',num2str(patch_x_right_edge),', y from:',num2str(patch_y_upper_edge),' to:',num2str(patch_y_lower_edge),' are outside image bounds x: 1-',num2str(dim_img_x), ', y:1-', num2str(dim_img_y));
       % error(msg);
        boolean_flag = false;
    end

    % Create and initialize a placeholder for the patch
    patch = zeros(patch_y_dim,patch_x_dim,channels);
    
    % Loop over all channels and get the patch from each
    for i = 1:channels
        % X and y must be switched to match the image dimension convention
        if boolean_flag == true
            patch(:,:,i) = image(patch_y_upper_edge:patch_y_lower_edge,patch_x_left_edge:patch_x_right_edge, i);
        end
    end
    
end
