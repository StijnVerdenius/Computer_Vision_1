function show(imgs, points, vectors)
close all

% make sure there is an equal number of frames
assert(isequal(size(imgs, 1), size(points, 1)), "Doesn't have tracked features for every frame in video");

% build figure
figure(1)

% loop through video
for frame = 1:size(imgs, 1)

   % plot videoframe
   imshow(imgs(frame).data)
   
   arrow_multiplication = 75;
   
   % plot points
   hold on
   for point = 1:size(points, 2)
       x = points(frame, point, 1);
       y = points(frame, point, 2);
       u = vectors(frame, point, 1)*arrow_multiplication;
       v = vectors(frame, point, 2)*arrow_multiplication;
       plot(x, y, 'r*');
       quiver(x,y,u,v,'color',[0 0 1]);
   end
   pause(0.75)
   hold off
end

end
