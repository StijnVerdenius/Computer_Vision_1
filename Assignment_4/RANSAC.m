I = single(imread('boat1.pgm'));

% Before RANSAC
[T, scores, k1, k2] = keypoint_matching('left.jpg', 'right.jpg');

% % Repeat N times
N = 10000;
P = 50;
number = size(T,2); % Total number of points
threshDist = 10;
current_inlier_count = 0;
current_params = zeros(1,6);
for n = 1:N
    % Pick P matches at random from total set of matches T
    permutations = randperm(size(T,2));
    subset = permutations(1:P);
    
    % Get corresponding points
    [x,x_,y,y_] = get_points_from_matches(T,k1,k2,subset);
    
    % Construct a matrix A and vector b using the P pairs of points
    [A,b] = build_A_b(x, x_, y, y_);
    
    % Solving the equation Ax = b 
    transf_params = pinv(A)*b;
   
    
    % Calculate new locations
    [xs_, ys_] = compute_new_loc(x,y, transf_params);
     
    % --- up to here there should be no confusion with x/y ---
  
    % Count inliners
     distance = sqrt(xs_.^2 + ys_.^2) - sqrt(x_.^2 + y_.^2)';
     inlier_count = length(find(abs(distance)<=threshDist));

     % Check if new count is better and if so, save params
     if inlier_count > current_inlier_count
        current_inlier_count = inlier_count;
        current_params = transf_params
     end
end

compute_new_img(imread('left.jpg'), current_params);