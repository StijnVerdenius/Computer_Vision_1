function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface


if nargin == 2
    path_type = 'column';
end

[h, w] = size(p);
height_map = zeros(h, w);

switch path_type
    case 'column'
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        height_map(1,1) = 0;
        
        % for each pixel in the left column of height_map
        for row = 2:h
            % height_value = previous_height_value + corresponding_q_value
            height_map(row,1) = height_map(row - 1, 1) + q(row, 1);
        end
        
        
        % for each row
        for row = 1:h
        %   for each element of the row except for leftmost
            for column = 2:w
        %       height_value = previous_height_value + corresponding_p_value
                height_map(row, column) = height_map(row, column - 1) + p(row, column);
            end
       end

       
        % =================================================================
               
    case 'row'
        
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        height_map(1,1) = 0;
        
        % for each pixel in the left column of height_map
        for column = 2:w
            % height_value = previous_height_value + corresponding_q_value
            height_map(1,column) = height_map(1, column - 1) + q(1, column);
        end
        
        
        % for each row
        for column = 1:w
        %   for each element of the row except for leftmost
            for row = 2:h
        %       height_value = previous_height_value + corresponding_p_value
                height_map(row, column) = height_map(row - 1, column) + q(row, column);
            end
       end

        % =================================================================
          
    case 'average'
        
        % =================================================================
        % YOUR CODE GOES HERE
        height_map_column = construct_surface( p, q, 'column');
        height_map_row = construct_surface( p, q, 'row');
        height_map = (height_map_column + height_map_row)/2;
        % =================================================================
end


end

