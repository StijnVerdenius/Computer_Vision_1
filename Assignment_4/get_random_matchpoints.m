function [] = get_random_matchpoints(image1, image2)

%Check if image is rgb and convert to gray if necessary
if ndims(imread(image1)) == 3
    I1 = rgb2gray(imread(image1));
else
    I1 = imread(image1);
end
  
if ndims(imread(image2)) == 3
    I2 = rgb2gray(imread(image2));
else
    I2 = imread(image2);
end   

%resize images to be of equal dimensions if necessary
if size(I1) ~= size(I2)
    I2 = imresize(I2,size(I1));
end

%convert to singles
I1 = im2single(I1);
I2 = im2single(I2);

%Get frames with features
[k1,d1] = vl_sift(I1);
[k2,d2] = vl_sift(I2);

%Get frames with matching features
[m, scores] = vl_ubcmatch(d1, d2);

%Get random subset of frames with matching features
permutations = randperm(size(m,2));
subset = permutations(1:10);


figure(1)

%plot images side by side
imshowpair(I1, I2 , 'montage')

%plot matched features on 1st image
f1 = vl_plotframe(k1(:,m(1,subset)));
set(f1,'color','b','linewidth',3) ;

%plot matched features on 2nd image 
k2(1,:) = k2(1,:) + size(I1,2);
f2 = vl_plotframe(k2(:,m(2,subset)));
set(f2,'color','g','linewidth',2) ;

%plot lines joining matched features
x1 = k1(1,m(1,subset));
x2 = k2(1,m(2,subset));
y1 = k1(2,m(1,subset));
y2 = k2(2,m(2,subset));

f3 = line([x1 ; x2], [y1 ; y2]) ;
set(f3,'linewidth', 2, 'color', 'r') ;

end
