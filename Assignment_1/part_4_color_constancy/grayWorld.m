function [c_img] = grayWorld(img)
% function to do the grayworld algorithm

% split colour channels
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);

% calculate means
m_R = mean(R, 'all');
m_G = mean(G, 'all');
m_B = mean(B, 'all');

% define gray value
gray = 128;

% calculate fractions
R_r = gray/m_R;
G_r = gray/m_G;
B_r = gray/m_B;

% normalize rgb's
n_R = R_r.*R;
n_G = G_r.*G;
n_B = B_r.*B;

% reconstruct image
c_img = cat(3,n_R,n_G,n_B);

end