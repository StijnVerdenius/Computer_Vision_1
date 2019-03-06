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
   
   % plot points
   hold on
   for point = 1:size(points, 2)
       i = points(frame, point, 1);
       j = points(frame, point, 2);
       u = vectors(frame, point, 1)*200;
       v = vectors(frame, point, 2)*200;
       plot(j, i, 'r*');
       quiver(j,i,u,v);
   end
   pause(.3)
   hold off
end

end
