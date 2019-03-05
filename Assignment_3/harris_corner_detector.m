function H = harris_corner_detector(Im)

sigma = 2;
n = 3;

N = 7;
threshold = 10;

I = im2double(Im);
I = rgb2gray(I);

dx = [1 0 -1; 1 0 -1; 1 0 -1];
dy = dx';

Ix = imfilter(I, dx);
Iy = imfilter(I, dy);

G = fspecial("gaussian", n, sigma);

IxIx = imfilter(Ix.^2, G);
IyIy = imfilter(Iy.^2, G);
IxIy = imfilter(Ix.*Iy, G);

figure(1)
subplot(2, 1, 1);
imshow(Ix);
title("image derivatives X'axis");
subplot(2, 1, 2);
imshow(Iy);
title("image derivatives Y'axis");


[r, c] = size(IxIx);
H = zeros(r, c);

for i=2:r-1
    for j=2:c-1
        
        A = sum(sum(IxIx(i-1:i+1, j-1:j+1)));
        B = sum(sum(IxIy(i-1:i+1, j-1:j+1)));
        C = sum(sum(IyIy(i-1:i+1, j-1:j+1)));
        
        H(i, j) = (A*C + B^2) - 0.04*(A+C)^2;
        
    end
end

% H = zscore(H, 1);

Edge = zeros(r, c);
step = floor(N/2);
for i=(step+1):r-(step+1)
    for j=(step+1):c-(step+1)
        Edge(i, j) = (H(i, j) == max(max(H(i-step:i+step, j-step:j+step)))) ...
                   & (H(i, j) > threshold);
    end
end

figure(2);
imshow(Im);
hold on;
for i=1:r
    for j=1:c
        if Edge(i, j) == 1
           plot(j, i, 'r*') 
        end
    end
end
hold off;
title("Harris Edge Detection");

end