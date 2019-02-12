function done = sayHello(names)
for i = 1:length(names)
    fprintf("Hello %s \n", names(i));
end
done = true;
end