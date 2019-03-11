function [] = disp_velocity_field(Vxs,Vys,img)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
close all;
figure(1)

[h,w] = size(Vxs);
[x,y] = meshgrid(1.5:1:h+0.5,1:1:w+0.5);
x = transpose(x);
y = transpose(y);
quiver(x,y,Vxs,Vys);
axis image %plot the quiver to see the dimensions of the plot
hax = gca; %get the axis handle
imshow(img, "XData", hax.XLim, "YData", hax.YLim); %plot the image within the axis limits
hold on; %enable plotting overwrite
quiver(x,y,Vxs,Vys);
grid on;
rows = 14;
cols = 14;
for row = 0.5 : 1 : rows + 0.5
  line([0, cols], [row, row], 'Color', 'w', 'LineStyle', ":");
end
for col = 0.5 : 1 : cols + 0.5
  line([col, col], [0, rows], 'Color', 'w', 'LineStyle', ":");
end
quiver(x,y,Vxs,Vys,'red','LineWidth',2);
end

