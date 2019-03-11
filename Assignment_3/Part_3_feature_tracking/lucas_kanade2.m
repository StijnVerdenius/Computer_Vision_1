function [Vx,Vy,inds_p,Vx_img,Vy_img] = lucas_kanade2(im1,im2,nh_size,outputImagesBool,pointsOfInterest,drawNHbool)
% Usage: [Vx,Vy,inds_p,Vx_img,Vy_img] = lucas_kanade(im1,im2,nh_size,outputImagesBool,pointsOfInterest)
%
% Inputs:
% im1 and im2:          images to compute optical flow with (can be colour)
% nh_size:              Size of one of the dimensions of a square neighbourhood in pixels
% outputImagesBool:     If true, also fills in the velocities of every
%                           pixel and returns as output images Vx and Vy
% pointsOfInterest:      If not empty, only compute optical flow for
%                       neigbourhoods centered on these points. Input as an
%                           2xn vector [r;c].

% Check for same size
if ~size(im1)==size(im2)
    error('Images should be the same size')
end
Vx_img = zeros(size(im1,1),size(im1,2));
Vy_img = Vx_img;

% Check for uneven nh_size
if (mod(nh_size,2)==0)
    error('Neighbourhood size should be uneven')
end

% Check if pointsOfInterest is filled
if ~isempty(pointsOfInterest)
    usePOI = true;
else
    usePOI = false;
end

% Convert to grayscale and double
[~,~,ch]=size(im1);

if ch==3
    im1 = rgb2gray(im1);
    im2 = rgb2gray(im2);
end
im1 = im2double(im1);
im2 = im2double(im2);

% Compute image derivatives
im1_x = diff(im1,1,2);
im1_y = diff(im1,1,1);
im2_x = diff(im2,1,2);
im2_y = diff(im2,1,1);

im_t = diff(cat(3,im1,im2),1,3);

if usePOI
    
    Vx = zeros(1,size(pointsOfInterest,2));
    Vy = Vx;
    
    inds_p = pointsOfInterest;
    
    for i=1:size(pointsOfInterest,2)
        
        currentPoint = pointsOfInterest(:,i);
        
        % Compute boundaries of neighbourhood centered on POI
        start_row = round(currentPoint(1)-floor(nh_size/2));
        end_row = round(currentPoint(1)+floor(nh_size/2));
        start_col = round(currentPoint(2)-floor(nh_size/2));
        end_col = round(currentPoint(2)+floor(nh_size/2));
        
        % Check if boundaries overlap image edges, if so, output zero
        % velocity
        if start_row<1 || start_col <1 || end_row > size(im1_y,1) || end_col > size(im1_x,2)
            disp('Neighbourhood boundaries for point overlap image boundaries, outputting zeros for this point');
            Vx(i) = 0;
            Vy(i) = 0;
        else
            % Compute for this neighbourhood (copy pasted from below)
            
            % extract the neighbourhood gradient images
            nh_im1_x = im1_x(start_row:end_row,start_col:end_col);
            nh_im1_y = im1_y(start_row:end_row,start_col:end_col);
            nh_im_t = im_t(start_row:end_row,start_col:end_col);
            
            % Populate the matrices
            A = [nh_im1_x(:) nh_im1_y(:)];
            At = A';
            b = -nh_im_t(:);
            
            % Solve the system of equations to get the x and y velocity
            v = inv(At*A)*At*b;
            
            % Save it in the vector
            Vx(i) = v(1);
            Vy(i) = v(2);
            
            % If this toggle is true, also output the velocities as images
            if outputImagesBool
                Vx_img(start_row:end_row,start_col:end_col) = v(1);
                Vy_img(start_row:end_row,start_col:end_col) = v(2);
            end
            
            % If true, draw this neighbourhood
            if drawNHbool
                
                drawNeighbourhood(start_col,end_col,start_row,end_row,'r');
                
            end
            
        end
        
    end
    
    
else
    % Compute number of non-overlapping neighbourhood patches (columns and
    % rows)
    nh_numrows = floor(size(im1_y,1)/nh_size);
    nh_numcols = floor(size(im1_x,2)/nh_size);
    
    % Initialize velocity vectors
    Vx = zeros(nh_numrows*nh_numcols,1);
    Vy = zeros(nh_numrows*nh_numcols,1);
    
    % Initialize index matrix for the centers of the neighbourhoods
    inds_p = zeros(nh_numrows*nh_numcols,2);
    
    % Do the estimation for each neighbourhood
    n=1;
    for i=1:nh_numrows
        for j=1:nh_numcols
            
            % Compute the indices bordering this neighbourhood
            start_row = (1+(i-1)*nh_size);
            end_row = (1+(i-1)*nh_size+nh_size-1);
            start_col = (1+(j-1)*nh_size);
            end_col = (1+(j-1)*nh_size+nh_size-1);
            
            inds_p(n,:) = [start_row+floor(nh_size/2),start_col+floor(nh_size/2)];
            
            % extract the neighbourhood gradient images
            nh_im1_x = im1_x(start_row:end_row,start_col:end_col);
            nh_im1_y = im1_y(start_row:end_row,start_col:end_col);
            nh_im_t = im_t(start_row:end_row,start_col:end_col);
            
            %%% These are apparently not necessary
            % nh_im2_x = im2_x(start_row:end_row,start_col:end_col);
            % nh_im2_y = im2_y(start_row:end_row,start_col:end_col);
            
            % Populate the matrices
            A = [nh_im1_x(:) nh_im1_y(:)];
            At = A';
            b = -nh_im_t(:);
            
            % Solve the system of equations to get the x and y velocity
            v = inv(At*A)*At*b;
            
            % Save it in the vector
            Vx(n) = v(1);
            Vy(n) = v(2);
            
            % If this toggle is true, also output the velocities as images
            if outputImagesBool
                Vx_img(start_row:end_row,start_col:end_col) = v(1);
                Vy_img(start_row:end_row,start_col:end_col) = v(2);
            end
            
            if drawNHbool
                
                drawNeighbourhood(start_col,end_col,start_row,end_row,'r');
                
            end
            
            n=n+1;
        end
    end
    
end




end