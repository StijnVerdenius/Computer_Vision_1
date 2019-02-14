function [] = grayWorld(image)

img = imread(image);

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

m_R = mean(R,'all');
m_G = mean(G, 'all');
m_B = mean(B, 'all');

gray = 128;

R_r = gray/m_R;
G_r = gray/m_G;
B_r = gray/m_B;

n_R = R_r.*R;
n_G = G_r.*G;
n_B = B_r.*B;

c_img = cat(3,n_R,n_G,n_B);

figure(1)

subplot(1,2,1)
imshow(img)
title('Original image')

subplot(1,2,2)
imshow(c_img)
title('Corrected image')

end