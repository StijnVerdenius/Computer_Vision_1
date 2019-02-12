
%% Hello world

x = 10/3;

fprintf('some number: %6.4f.\n',x);
fprintf('some number again with less detail: %6.2f.\n',x);

%% File reading and function calling

filename = 'names.txt';
delimiterIn = ' ';
headerlinesIn = 1;
loaded =  tdfread(filename,delimiterIn);

newArray = strings(4,1);

for i = 1:4
    newArray(i)= string(loaded.Names(i,:));
end

finished = sayHello(newArray);

fprintf('Said hello to everyone: %s.\n',string(finished));


%% Start matlab tutorial: Section 1


%1.1
s1 = 5;
s2 = 5;
s3 = 6.02 * 10^23;
s4 = log(exp(4));
s5 = sqrt(s4);
s6 = s2/s5;

%1.2

v1 = [1,2,3,4]; % row
v2 = [1;2;3;4]; % column
v3 = v2';
v4 = 0:2:10;
v5 = 10;-2:0;
v6 = 'I am a string'; % actually chararray

% 1.3

m1 = ones(10)*3;
m2 = eye(5);
m3 = diag([1,2,3,33,333]);
m4 = [10, 20; 30, 40];
m5 = [2,4; 3, 5];
m6 = m4/m5;
m7 = m4 ./ m5;
m8 = det(m7);
m9 = m7';
m10 = m9(:);

% 1.4

A = [1,2,3;4,5,6;7,8,9];
B = A .* 10;
i1 = [A,B;B,A];
i2 = A(1:2, 1);
i3 = A(:, 1);
A(1, :) = B(2,:);
A(2,1) = 33;
B(5,5) = 55;
i4 = B(1:2:5);
B(1:3, :) = B(1:3, :) + 100;
i5 = B(end);

% 1.5

fprintf('Sure\n');

% 1.6

%1
vec = 10:2:49;

%2

X = [2,3,1,9];
X16 = X + 16;
sum_X = sum(X);
sorted_X = sort(X);
sum_odd_X = sum(X(1:2:length(X)));

%3

X = [5; 3; 1; 8];
Y =  [4 1 7 5];
pow = X' .^ Y;
div = X ./ Y';

% 4
t =  1:0.1:2.0;
a = log(2+t+t.^2);
b = exp(1 + cos(3.*t));
c = cos(t).^2 + sin(t).^2;
d = atan(t);

% 5

% i skip bc too easy

% 6

A = [2 4 1; 6 7 2; 3 5 9];
x = A(1,:);
y = A(end-1:end,:);
c = sum(A, 1);
d = sum(A, 2);
e = mean(mean(A));
f = std2(A);

% 7 commented out fails

x= [6 1 -8];
y= [1 1 2];
A= [-3 0 3; 6 -2 6];

x + y;
x + A;
x'+ y;
% B = A - [x', y']; % dimensions
% B = [x; y']; % dimensions
% B = A + A'; % dimensions
A + 18;

% 8 

x= [1 5 2 8 9 0 1];
y= [5 2 2 6 0 0 2];


answer = x<y;
answer = y<= x;
% answer = y ∼= x; gives me an error
answer = x == y;
answer = x|y;
answer = x & y;

% 9 skipped most

A= [2 7 9 7;  3 1 5 6;  8 1 2 5];

B = flipud(A);
B = fliplr(A);
B = size(A);

%% Section 2: Potting

x = 0:pi/100:2*pi;
% defines the interval of the function
y = sin(x);
% defines the function we want to plot
plot(x, y);
title('2-D Line Plot','FontSize', 20); % title of the figure
xlabel('x','FontSize', 20); % label for x axis
ylabel('sin(x)','FontSize', 20); % lab

% range of x and y values
x = -2:0.2:2;
y = -2:0.2:2;
[X, Y] = meshgrid(x, y);
% generates the actual grid of x and y values
Z = X .* exp(-X.^2 - Y.^2);
% function we want to plot
surf(X, Y, Z)
title('3-D Surface Plot','FontSize', 30);
xlabel('x','FontSize', 30);
ylabel('y','FontSize', 30);
zlabel('z','FontSize', 30);

% 2.3

% 1

x = -4:0.01:4;
y = 5.*x.^3-3.*x.^2+ 7.*x.^-2;
plot(x,y);
title('2-D Line Plot','FontSize', 20); % title of the figure
xlabel('x','FontSize', 20); % label for x axis
ylabel('sin(x)','FontSize', 20); % lab

% 2
[X, Y] = meshgrid(x, y);
Z = (sin(Y.^2+X)-cos(Y-X.^2));
surf(X, Y, Z);
title('3-D Surface Plot','FontSize', 30);
xlabel('x','FontSize', 30);
ylabel('y','FontSize', 30);
zlabel('z','FontSize', 30);

%% Section 3: imgproc

% 3.1 % jpeg -> png

I = imread('trump.jpeg');
% reads the image into marrix I
size(I); % 384 x 512 x 3 = row x columns x color channels (RGB in this case)
figure(1); % creates a figure on the screen
imshow(I); % displays the matrix I as an image
imwrite (I, 'myimage.png'); % writes image data I

% 3.2

% 1. grayscaling skipped

% 2. histogram and contrast

J = imread('trump.jpeg');
% read a grayscale image into matrix I
figure(3) % creates a figure on the screen
imhist(J) % displays the distribution of image pixel intensities
% Notice how the histogram indicates that the intensity range of the image is 
%rather narrow.  The range does not cover the potential range of [0, 255], and % ismissing the high and low values that would result in good contrast.
J2 = histeq(J);
% spreads the intensity values over the full range of the image
figure(4) % creates a figure on the screen
imshow(J2) % displays contrast enhanced image
figure(5) % creates a figure on the screen
imshow(J) % displays original image

% 3. scaling

P = imread('trump.jpeg'); 
% read an image into matrix P
figure(6) ;
% creates a figure on the screen
imshow(P) ;
% display the original image
S = imresize(P, 0.5) ;
% scale the original image into its half size
figure(7) ;
% creates a figure on the screen
imshow(S); 
% display the scaled image

%% Section 4: 

% kinda already done in sayHello.m
 
outcome = mySum(1,2);

function [ result ] = mySum(num1, num2)
%Returns the sum of the input arguments.
result = num1 + num2;
end

%% Section 5:


% 5.1


% 5.2


% 5.3



