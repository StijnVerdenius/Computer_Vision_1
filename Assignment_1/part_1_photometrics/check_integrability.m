function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

% initalization
[h,w,c] = size(normals);
p = zeros([h,w]);
q = zeros([h,w]);
SE = zeros(size(normals));

% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy
p = (normals(:,:,1))./(normals(:,:,3));
q = (normals(:,:,2))./(normals(:,:,3));
% ========================================================================
p(isnan(p)) = 0;
q(isnan(q)) = 0;

% ========================================================================
% YOUR CODE GOES HERE

% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE

dpdy = zeros([h,w]);
dqdx = zeros([h,w]);

%dpdy = gradient(p);
%dqdx = gradient(q);
dpdy(:,2:end) = p(:,1:end-1) - p(:,2:end);
dqdx(2:end,:) = q(1:end-1,:) - q(2:end,:);

SE = (dpdy - dqdx).^2;

height_vals = zeros([h,w]);
height_vals(1,1) = 0;

for row = 2:h
    height_vals(row,1) = height_vals(row-1,1) + q(row,1);
end

for row = 1:h
    for column = 2:w
        height_vals(row,column) = height_vals(row,column - 1) + p(row,column);
    end
end

% ========================================================================

end

