function show(imgs, points, vectors)
close all

% make sure there is an equal number of frames
% assert(isequal(size(imgs, 1), size(points, 1)), "Doesn't have tracked features for every frame in video");

% build figure
figure(1)

% loop through video
for frame = 1:size(imgs, 1)
    
   frame

   % plot videoframe
   imshow(imgs(frame).data)
   
   arrow_multiplication = 1;
   
   % plot points
   hold on
   for point = 1:size(points, 2)
       i = points(frame, point, 1);
       j = points(frame, point, 2);
       u = vectors(frame, point, 1)*arrow_multiplication;
       v = vectors(frame, point, 2)*arrow_multiplication;
       plot(j, i, 'r*');
       quiver(j,i,u,v);
       y_x_v1_v2 = [i,j,u/arrow_multiplication,v/arrow_multiplication]
   end
   pause(1)
   hold off
end

end
