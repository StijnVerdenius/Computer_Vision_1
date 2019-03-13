function [m1,m2,m3,m4,t1,t2,count, tries] = RANSAC(img1_dir,img2_dir)
[T, scores, k1, k2] = keypoint_matching(img1_dir,img2_dir);

% % Repeat N times
N = 10000;
P = 20;
number = size(T,2); % Total number of points
threshDist = 10;
current_inlier_count = 0;
current_params = zeros(1,6);
count = 0;
tries = 0;
for n = 1:N
    % Pick P matches at random from total set of matches T
    permutations = randperm(size(T,2));
    subset = permutations(1:P);
    
    % Get corresponding pointsi
    [x,x_,y,y_] = get_points_from_matches(T,k1,k2,subset);
    
    % Construct a matrix A and vector b using the P pairs of points
    [A,b] = build_A_b(x', x_', y', y_');
    
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
        current_params = transf_params;
        count = count + 1;
        tries = n;
     end
     
%      [new_img] = compute_new_img(imread(img1_dir), current_params);
    
%      % Draw transformation
%      figure(1)
% 
%     %plot images side by sidecount
%     imshowpair(imread(img1_dir), single(new_img) , 'montage')
% 
%     %plot matched features on 1st image
%     f1 = vl_plotframe(k1(:,T(1,subset)));
%     set(f1,'color','b','linewidth',3) ;
% 
%     %plot matched features on 2nd image 
%     k2(1,:) = k2(1,:) + size(imread(img1_dir),2);
%     f2 = vl_plotframe(k2(:,T(2,subset)));
%     set(f2,'color','g','linewidth',2) ;
% 
%     %plot lines joining matched features
%     x1 = k1(1,T(1,subset));
%     x2 = k2(1,T(2,subset));
%     y1 = k1(2,T(1,subset));
%     y2 = k2(2,T(2,subset));
% 
%     f3 = line([x1 ; x2], [y1 ; y2]) ;
%     set(f3,'linewidth', 2, 'color', 'r') ;

end



m1 = current_params(1);
m2 = current_params(2);
m3 = current_params(3);
m4 = current_params(4);
t1 = current_params(5);
t2 = current_params(6);
% compute_new_img(imread('boat2.pgm'), current_params);

end

