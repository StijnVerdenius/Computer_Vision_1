function show(imgs, points)
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
       i = round(points(frame, point, 1));
       j = round(points(frame, point, 2));
       plot(j, i, 'r*');
   end
   pause(.1)
   hold off
end

end
