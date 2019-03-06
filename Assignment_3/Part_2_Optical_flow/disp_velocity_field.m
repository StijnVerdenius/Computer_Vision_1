function [] = disp_velocity_field(Vxs,Vys,img)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[h,w] = size(Vxs);
[x,y] = meshgrid(1:1:h,1:1:w);
quiver(x,y,Vxs,Vys);
axis image %plot the quiver to see the dimensions of the plot
hax = gca; %get the axis handle
image(hax.XLim,hax.YLim,img); %plot the image within the axis limits
hold on; %enable plotting overwrite
quiver(x,y,Vxs,Vys);
end

